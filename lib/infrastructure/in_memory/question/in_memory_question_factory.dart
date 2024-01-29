import '../../../domain/shared/subject.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/seen_count.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/answer_list/models/answer_list.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/i_question_factory.dart';

class InMemoryQuestionFactory implements IQuestionFactory {
  final IQuestionRepository _repository;

  InMemoryQuestionFactory(final IQuestionRepository repository)
      : _repository = repository;
  @override
  Future<Question> createQuestion(
    Subject questionSubject,
    StudentId studentId,
    QuestionTitle questionTitle,
    QuestionText questionText,
    QuestionPhotoPathList questionPhotoPathList,
    SelectedTeacherList selectedTeacherList,
  ) async {
    final QuestionId questionId = _repository.generateId();

    final AnswerList answerList = AnswerList(answerList: []);
    final SeenCount seenCount = SeenCount(0);
    const bool questionResolved = false;

    return Question(
        questionId: questionId,
        questionSubject: questionSubject,
        questionTitle: questionTitle,
        questionText: questionText,
        questionPhotoPathList: questionPhotoPathList,
        studentId: studentId,
        answerList: answerList,
        seenCount: seenCount,
        questionResolved: questionResolved,
        selectedTeacherList: selectedTeacherList);
  }
}
