import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/question/models/question_photo_path.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../utils/zip.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';
import 'question_edit_command.dart';
import 'utils/photo_processing.dart';

class QuestionEditUseCase {
  final Session _session;
  final IQuestionRepository _repository;
  final IPhotoRepository _photoRepository;
  final ILogger _logger;

  QuestionEditUseCase({
    required final Session session,
    required final IQuestionRepository repository,
    required final IPhotoRepository photoRepository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _photoRepository = photoRepository,
        _logger = logger;

  void execute(final QuestionEditCommand command) async {
    _logger.info('BEGIN $QuestionEditUseCase.execute()');

    final StudentId studentId = _session.studentId;
    final QuestionId questionId = command.questionId;
    final Question? question = await _repository.findById(questionId);

    if (question == null) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.questionNotFound);
    }

    if (question.canEdit(studentId) == false) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.failedEditing);
    }

    final newTitle = command.questionTitleData;
    final newText = command.questionTextData;
    final newLocalPathList = command.localPathList;
    final newSelectedTeacherList = command.selectedTeacherList;

    if (newTitle != null) {
      question.changeQuestionTitle(QuestionTitle(newTitle));
    }

    if (newText != null) {
      question.changeQuestionText(QuestionText(newText));
    }

    if (newSelectedTeacherList != null) {
      question.changeSelectedTeacherList(SelectedTeacherList(
          newSelectedTeacherList
              .map((selectedTeacher) => TeacherId(selectedTeacher))
              .toList()));
    }

    if (newLocalPathList != null) {
      // create photo path list and proccess the images
      final oldQuestionPhotoPathList = question.questionPhotoPathList;

      final needChangePathList = newLocalPathList
          .where((localPath) =>
              !oldQuestionPhotoPathList.contains(QuestionPhotoPath(localPath)))
          .toList();
      final questionPhotoPathList = createPathListFromId(
          studentId: studentId, localPathList: needChangePathList);
      final processedImageList = resizeAndForMultiplePhoto(needChangePathList);

      final questionPhotoList = <QuestionPhoto>[];

      for (var [path, image]
          in zip(questionPhotoPathList, processedImageList)) {
        final questionPhoto = QuestionPhoto.fromImage(path: path, image: image);
        questionPhotoList.add(questionPhoto);
      }

      for (final sameQuestionPhotoPath in newLocalPathList.where((localPath) =>
          oldQuestionPhotoPathList.contains(QuestionPhotoPath(localPath)))) {
        questionPhotoPathList.toList().insert(
            newLocalPathList.indexOf(sameQuestionPhotoPath),
            QuestionPhotoPath(sameQuestionPhotoPath));
      }

      await _photoRepository.save(questionPhotoList);

      // delete the old images
      await _photoRepository.deleteList(QuestionPhotoPathList(
          oldQuestionPhotoPathList
              .where((oldQuestionPhotoPath) =>
                  !questionPhotoPathList.contains(oldQuestionPhotoPath))
              .toList()));

      // change the question's photo to the new one
      question.changeQuestionPhotoPathList(questionPhotoPathList);
    }

    await _repository.save(question);

    _logger.info('END $QuestionEditUseCase.execute()');
  }
}
