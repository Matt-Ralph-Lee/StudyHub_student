import '../../../domain/answer_list/models/answer.dart';
import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/answer_like.dart';
import '../../../domain/answer_list/models/answer_photo_path_list.dart';
import '../../../domain/answer_list/models/answer_text.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../question/in_memory_question_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';

class InMemoryAnswerRepository implements IAnswerRepository {
  late Map<AnswerId, Answer> store;
  static final InMemoryAnswerRepository _instance =
      InMemoryAnswerRepository._internal();

  factory InMemoryAnswerRepository() {
    return _instance;
  }

  InMemoryAnswerRepository._internal() {
    store = {
      InMemoryAnswerInitialValue.answer1FromT1ToQ1.answerId:
          InMemoryAnswerInitialValue.answer1FromT1ToQ1,
      InMemoryAnswerInitialValue.answer2FromT2ToQ2.answerId:
          InMemoryAnswerInitialValue.answer2FromT2ToQ2,
      InMemoryAnswerInitialValue.answer3FromT2ToQ2.answerId:
          InMemoryAnswerInitialValue.answer3FromT2ToQ2,
    };
  }

  @override
  List<Answer> getByQuestionId(final QuestionId questionId) {
    return store.values
        .where((answer) => answer.questionId == questionId)
        .toList();
  }
}

class InMemoryAnswerIdInitialValue {
  static final answerId1FromT1ToQ1 = AnswerId('00000000000000000001');
  static final answerId2FromT2ToQ2 = AnswerId('00000000000000000002');
  static final answerId3FromT2ToQ2 = AnswerId('00000000000000000003');
}

class InMemoryAnswerInitialValue {
  static final answer1FromT1ToQ1 = Answer(
    answerId: InMemoryAnswerIdInitialValue.answerId1FromT1ToQ1,
    questionId: InMemoryQuestionIdInitialValue.questionId1FromS1,
    answerText: AnswerText("こうやるんだよ"),
    answerPhotoPathList: AnswerPhotoPathList([]),
    like: AnswerLike(12),
    teacherId: InMemoryTeacherInitialValue.teacher1.teacherId,
    evaluated: false,
  );

  static final answer2FromT2ToQ2 = Answer(
    answerId: InMemoryAnswerIdInitialValue.answerId2FromT2ToQ2,
    questionId: InMemoryQuestionIdInitialValue.questionId2FromS2,
    answerText: AnswerText("ひゅーってやってひょいだよ、ひゅーひょい。わかんない？センスねぇー"),
    answerPhotoPathList: AnswerPhotoPathList([]),
    like: AnswerLike(1),
    teacherId: InMemoryTeacherInitialValue.teacher2.teacherId,
    evaluated: true,
  );

  static final answer3FromT2ToQ2 = Answer(
    answerId: InMemoryAnswerIdInitialValue.answerId3FromT2ToQ2,
    questionId: InMemoryQuestionIdInitialValue.questionId2FromS2,
    answerText: AnswerText("そうそう、それであってるよ"),
    answerPhotoPathList: AnswerPhotoPathList([]),
    like: AnswerLike(4),
    teacherId: InMemoryTeacherInitialValue.teacher2.teacherId,
    evaluated: true,
  );
}
