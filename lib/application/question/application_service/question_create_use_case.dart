import '../../../domain/shared/subject.dart';
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
import '../../shared/session/i_session.dart';
import 'utils/photo_processing.dart';

class QuestionCreateUseCase {
  final ISession _session;
  final IQuestionRepository _repository;
  final IQuestionFactory _factory;
  final IPhotoRepository _photoRepository;

  QuestionCreateUseCase({
    required final ISession session,
    required final IQuestionRepository repository,
    required final IQuestionFactory factory,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _factory = factory,
        _photoRepository = photoRepository;

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
    final selectedTeacherList =
        SelectedTeacherList(selectedTeacherList: selectedTeacherListData);

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

    _repository.save(question);
  }
}
