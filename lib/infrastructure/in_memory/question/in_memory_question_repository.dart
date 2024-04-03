import '../../../domain/answer_list/models/answer_list.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/question/models/question_photo_path.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/seen_count.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/shared/subject.dart';
import '../answer/in_memory_answer_repository.dart';
import '../student/in_memory_student_repository.dart';

class InMemoryQuestionRepository implements IQuestionRepository {
  late Map<QuestionId, Question> store;
  late int _idInt;
  static final InMemoryQuestionRepository _instance =
      InMemoryQuestionRepository._internal();

  factory InMemoryQuestionRepository() {
    return _instance;
  }

  InMemoryQuestionRepository._internal() {
    store = {
      InMemoryQuestionInitialValue.question1FromS1.questionId:
          InMemoryQuestionInitialValue.question1FromS1,
      InMemoryQuestionInitialValue.question2FromS2.questionId:
          InMemoryQuestionInitialValue.question2FromS2,
    };
    _idInt = 1000000;
  }

  @override
  void delete(final QuestionId questionId) {
    store.remove(questionId);
  }

  @override
  Question? findById(final QuestionId questionId) {
    return store[questionId];
  }

  @override
  QuestionId generateId() {
    const idStr = "thisIsATestId";

    String randomId = _idInt.toString() + idStr;

    _idInt++;

    return QuestionId(randomId);
  }

  @override
  void save(final Question question) {
    store[question.questionId] = question;
  }
}

class InMemoryQuestionIdInitialValue {
  static final questionId1FromS1 = QuestionId('00000000000000000001');
  static final questionId2FromS2 = QuestionId('00000000000000000002');
}

class InMemoryQuestionInitialValue {
  static final question1FromS1 = Question(
    questionId: InMemoryQuestionIdInitialValue.questionId1FromS1,
    questionSubject: Subject.highMath,
    questionTitle: QuestionTitle('微分について'),
    questionText: QuestionText('微分ってなんすか？'),
    questionPhotoPathList: QuestionPhotoPathList([]),
    studentId: InMemoryStudentInitialValue.student1.studentId,
    answerList: AnswerList([InMemoryAnswerInitialValue.answer1FromT1ToQ1]),
    seenCount: SeenCount(10),
    selectedTeacherList: SelectedTeacherList([]),
    resolved: true,
  );

  static final question2FromS2 = Question(
    questionId: InMemoryQuestionIdInitialValue.questionId2FromS2,
    questionSubject: Subject.midEng,
    questionTitle: QuestionTitle('文型について'),
    questionText: QuestionText(
        '文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？文型ってなんすか？v文型ってなんすか？文型ってなんすか？文型ってなんすか？'),
    questionPhotoPathList: QuestionPhotoPathList([
      QuestionPhotoPath("assets/images/sample_picture_hd.jpg"),
      QuestionPhotoPath("assets/images/sample_picture_hd.jpg"),
    ]),
    studentId: InMemoryStudentInitialValue.userStudentId,
    answerList: AnswerList([
      InMemoryAnswerInitialValue.answer2FromT2ToQ2,
      InMemoryAnswerInitialValue.answer3FromT1ToQ2,
    ]),
    seenCount: SeenCount(20),
    selectedTeacherList: SelectedTeacherList([]),
    resolved: true,
  );
}
