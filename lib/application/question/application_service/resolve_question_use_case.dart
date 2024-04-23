import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';

class ResolveQuestionUseCase {
  final IQuestionRepository _repository;

  ResolveQuestionUseCase(this._repository);

  Future<void> execute({
    required final StudentId studentId,
    required final QuestionId questionId,
  }) async {
    final isMyQuestion = await _repository.checkIsMyQuestion(
        studentId: studentId, questionId: questionId);
    if (isMyQuestion) {
      await _repository.resolveQuestion(questionId);
      return;
    }
    throw const QuestionUseCaseException(
        QuestionUseCaseExceptionDetail.notAllowedToResolve);
  }
}
