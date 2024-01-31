import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';

import '../../shared/session/i_session.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/photo/models/i_profile_photo_repository.dart';

import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';

class QuestionDeleteUseCase {
  final ISession _session;
  final IQuestionRepository _repository;
  final IPhotoRepository _photoRepository;

  QuestionDeleteUseCase({
    required final ISession session,
    required final IQuestionRepository repository,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _photoRepository = photoRepository;

  void execute(final QuestionId questionId) {
    final studentId = _session.studentId;

    final Question? question = _repository.findById(questionId);
    if (question == null) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.questionNotFound);
    }

    if (question.canDelete(studentId)) {
      final questionPhotoPathList = question.questionPhotoPathList;
      for (var i = 0; i < questionPhotoPathList.length; i++) {
        _photoRepository.deleteList(questionPhotoPathList);
      }

      _repository.delete(question.questionId);
    } else {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.failedDeleting);
    }
  }
}
