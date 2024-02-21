import '../../teacher/models/teacher_id.dart';
import 'answer_id.dart';
import 'answer_photo_path_list.dart';
import 'answer_text.dart';
import 'answer_like.dart';

class Answer {
  final AnswerId _answerId;
  final AnswerText _answerText;
  final AnswerPhotoPathList _answerPhotoPathList;
  final AnswerLike _like;
  final TeacherId _teacherId;
  final bool _evaluated;

  AnswerId get answerId => _answerId;
  AnswerText get answerText => _answerText;
  AnswerPhotoPathList get answerPhotoPathList => _answerPhotoPathList;
  AnswerLike get like => _like;
  TeacherId get teacherId => _teacherId;
  bool get evaluated => _evaluated;

  Answer({
    required final AnswerId answerId,
    required final AnswerText answerText,
    required final AnswerPhotoPathList answerPhotoPathList,
    required final AnswerLike like,
    required final TeacherId teacherId,
    required final bool evaluated,
  })  : _answerId = answerId,
        _answerText = answerText,
        _answerPhotoPathList = answerPhotoPathList,
        _like = like,
        _teacherId = teacherId,
        _evaluated = evaluated;

  // studentのアプリでは必要ないと判断
  // 下記の編集権限はteacherIdと一致することを確認する
  // void changeAnswerText(final AnswerText newAnswerText) {
  //   _answerText = newAnswerText;
  // }

  // void changeAnswerPhotoPathList(final AnswerPhotoPathList newAnswerPhotoList) {
  //   _answerPhotoPathList = newAnswerPhotoList;
  // }
}
