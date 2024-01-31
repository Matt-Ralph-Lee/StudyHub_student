import '../../../domain/photo/models/i_profile_photo_repository.dart';
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
import '../../shared/session/i_session.dart';
import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';
import 'question_edit_command.dart';
import 'utils/photo_processing.dart';

class QuestionEditUseCase {
  final ISession _session;
  final IQuestionRepository _repository;
  final IPhotoRepository _photoRepository;

  QuestionEditUseCase({
    required final ISession session,
    required final IQuestionRepository repository,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _photoRepository = photoRepository;

  void execute(QuestionEditCommand command) {
    final StudentId studentId = _session.studentId;
    final QuestionId questionId = command.questionId;
    final Question? question = _repository.findById(questionId);

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
          selectedTeacherList: newSelectedTeacherList
              .map((selectedTeacher) => TeacherId(selectedTeacher))
              .toList()));
    }

    if (newLocalPathList != null) {
      // create photo path list and proccess the images
      final questionPhotoPathList = createPathListFromId(
          studentId: studentId, localPathList: newLocalPathList);
      final processedImageList =
          resizeAndConvertToJpgForMultiplePhoto(newLocalPathList);

      final questionPhotoList = <QuestionPhoto>[];

      for (var [path, image]
          in zip(questionPhotoPathList, processedImageList)) {
        final questionPhoto = QuestionPhoto.fromImage(path: path, image: image);
        questionPhotoList.add(questionPhoto);
      }

      _photoRepository.save(questionPhotoList);

      // delete the old images
      final oldQuestionPhotoPathList = question.questionPhotoPathList;
      for (var i = 0; i < oldQuestionPhotoPathList.length; i++) {
        _photoRepository.deleteList(oldQuestionPhotoPathList);
      }

      // change the question's photo to the new one
      question.changeQuestionPhotoPathList(questionPhotoPathList);
    }

    _repository.save(question);
  }
}
