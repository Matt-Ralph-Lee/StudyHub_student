import '../../../domain/answer_list/models/answer.dart';
import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/answer_like.dart';
import '../../../domain/answer_list/models/answer_photo_path_list.dart';
import '../../../domain/answer_list/models/answer_text.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class InMemoryAnswerRepository implements IAnswerRepository {
  late Map<AnswerId, Map<QuestionId, Answer>> store;
  static final InMemoryAnswerRepository _instance =
      InMemoryAnswerRepository._internal();

  factory InMemoryAnswerRepository() {
    return _instance;
  }

  InMemoryAnswerRepository._internal() {
    store = {
      AnswerId('00000000000000000001'): {
        QuestionId('00000000000000000001'): Answer(
          answerId: AnswerId('00000000000000000001'),
          answerText: AnswerText("こうやるんだよ"),
          answerPhotoPathList: AnswerPhotoPathList([]),
          like: AnswerLike(12),
          teacherId: TeacherId('00000000000000000001'),
          evaluated: false,
        ),
      },
      AnswerId('00000000000000000002'): {
        QuestionId('00000000000000000002'): Answer(
          answerId: AnswerId('00000000000000000002'),
          answerText: AnswerText("ひゅーってやってひょいだよ、ひゅーひょい。わかんない？センスねぇー"),
          answerPhotoPathList: AnswerPhotoPathList([]),
          like: AnswerLike(1),
          teacherId: TeacherId('00000000000000000002'),
          evaluated: true,
        ),
      },
      AnswerId('00000000000000000003'): {
        QuestionId('00000000000000000002'): Answer(
          answerId: AnswerId('00000000000000000003'),
          answerText: AnswerText("そうそう、それであってるよ"),
          answerPhotoPathList: AnswerPhotoPathList([]),
          like: AnswerLike(4),
          teacherId: TeacherId('00000000000000000002'),
          evaluated: true,
        ),
      },
    };
  }

  @override
  List<Answer> getByQuestionId(QuestionId questionId) {
    final result = store.values
        .where((element) => element.keys.first == questionId)
        .map((e) => e.values.first)
        .toList();

    return result;
  }
}
