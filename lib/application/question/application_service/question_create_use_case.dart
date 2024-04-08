import '../../../domain/notification/models/i_notification_factory.dart';
import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_list.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_sender_type.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../utils/zip.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/i_question_factory.dart';
import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../shared/session/session.dart';
import 'i_question_create_query_service.dart';
import 'utils/photo_processing.dart';

class QuestionCreateUseCase {
  final Session _session;
  final IQuestionRepository _repository;
  final IQuestionFactory _factory;
  final IPhotoRepository _photoRepository;
  final INotificationRepository _notificationRepository;
  final INotificationFactory _notificationFactory;
  final IQuestionCreateQueryService _queryService;

  QuestionCreateUseCase({
    required final Session session,
    required final IQuestionRepository repository,
    required final IQuestionFactory factory,
    required final IPhotoRepository photoRepository,
    required final INotificationRepository notificationRepository,
    required final INotificationFactory notificationFactory,
    required final IQuestionCreateQueryService queryService,
  })  : _session = session,
        _repository = repository,
        _factory = factory,
        _photoRepository = photoRepository,
        _notificationRepository = notificationRepository,
        _notificationFactory = notificationFactory,
        _queryService = queryService;

  Future<void> execute({
    required final String questionTitleData,
    required final String questionTextData,
    required final List<String> localPathList,
    required final Subject questionSubject,
    required final List<TeacherId> selectedTeacherListData,
  }) async {
    final studentId = _session.studentId;
    final questionTitle = QuestionTitle(questionTitleData);
    final questionText = QuestionText(questionTextData);
    final selectedTeacherList = SelectedTeacherList(selectedTeacherListData);

    final question = await _createQuestion(
        studentId: studentId,
        localPathList: localPathList,
        questionSubject: questionSubject,
        questionTitle: questionTitle,
        questionText: questionText,
        selectedTeacherList: selectedTeacherList);

    _repository.save(question);

    if (question.selectedTeacherList.isNotEmpty) {
      final notification = await _createNotification(
        studentId: studentId,
        question: question,
      );

      await _notificationRepository.save(notification);
    }
  }

  Future<Question> _createQuestion({
    required final StudentId studentId,
    required final List<String> localPathList,
    required final Subject questionSubject,
    required final QuestionTitle questionTitle,
    required final QuestionText questionText,
    required final SelectedTeacherList selectedTeacherList,
  }) async {
    final questionPhotoPathList = createPathListFromId(
        studentId: studentId, localPathList: localPathList);

    final processedImageList =
        resizeAndConvertToJpgForMultiplePhoto(localPathList);

    final questionPhotoList = <QuestionPhoto>[];
    for (var [path, image] in zip(questionPhotoPathList, processedImageList)) {
      final questionPhoto = QuestionPhoto.fromImage(path: path, image: image);
      questionPhotoList.add(questionPhoto);
    }

    _photoRepository.save(questionPhotoList);

    final Question question = await _factory.createQuestion(
        questionSubject: questionSubject,
        studentId: studentId,
        questionTitle: questionTitle,
        questionText: questionText,
        questionPhotoPathList: questionPhotoPathList,
        selectedTeacherList: selectedTeacherList);
    return question;
  }

  Future<Notification> _createNotification({
    required final StudentId studentId,
    required final Question question,
  }) async {
    final senderPhotoPath = await _queryService.getProfilePhotoPath(studentId);
    final sender = NotificationSender(
        senderType: NotificationSenderType.student,
        senderId: studentId,
        senderPhotoPath: senderPhotoPath);
    final target = NotificationTarget(
        targetType: NotificationTargetType.question,
        targetId: question.questionId);
    final title = NotificationTitle(question.questionTitle.value);
    final text = NotificationText(question.questionText.value);

    List<NotificationReceiver> receiverList = [];
    for (var teacherId in question.selectedTeacherList) {
      final receiver = NotificationReceiver(
        receiverType: NotificationReceiverType.teacher,
        receiverId: teacherId,
      );
      receiverList.add(receiver);
    }

    final notification = await _notificationFactory.create(
      sender: sender,
      receiverList: NotificationReceiverList(receiverList),
      target: target,
      title: title,
      text: text,
      postedAt: DateTime.now(),
    );

    return notification;
  }
}
