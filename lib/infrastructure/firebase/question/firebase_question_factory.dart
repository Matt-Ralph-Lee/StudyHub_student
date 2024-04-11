import '../../../domain/answer_list/models/answer_list.dart';
import '../../../domain/question/models/i_question_factory.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/seen_count.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';
import 'firebase_question_repository.dart';

class FirebaseQuestionFactory implements IQuestionFactory {
  final FirebaseQuestionRepository _repository;

  FirebaseQuestionFactory(this._repository);

  @override
  Future<Question> createQuestion({
    required Subject questionSubject,
    required StudentId studentId,
    required QuestionTitle questionTitle,
    required QuestionText questionText,
    required QuestionPhotoPathList questionPhotoPathList,
    required SelectedTeacherList selectedTeacherList,
  }) async {
    final questionId = await _repository.generateId();

    final answerList = AnswerList([]);
    final seenCount = SeenCount(0);
    const bool resolved = false;

    return Question(
        questionId: questionId,
        questionSubject: questionSubject,
        questionTitle: questionTitle,
        questionText: questionText,
        questionPhotoPathList: questionPhotoPathList,
        studentId: studentId,
        answerList: answerList,
        seenCount: seenCount,
        resolved: resolved,
        selectedTeacherList: selectedTeacherList);
  }
}
