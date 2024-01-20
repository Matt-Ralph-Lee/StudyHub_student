import 'answer_id.dart';
import 'answer_photo_path_list.dart';
import 'answer_text.dart';

class Answer {
  final AnswerId _answerId;
  final AnswerText _answerText;
  final AnswerPhotoPathList _answerPhotoPathList;
  final int _like;

  AnswerId get answerId => _answerId;
  AnswerText get answerText => _answerText;
  AnswerPhotoPathList get answerPhotoPathList => _answerPhotoPathList;
  int get like => _like;

  //TODO: teacher

  Answer({
    required final AnswerId answerId,
    required final AnswerText answerText,
    required final AnswerPhotoPathList answerPhotoPathList,
    required final int like,
  })  : _answerId = answerId,
        _answerText = answerText,
        _answerPhotoPathList = answerPhotoPathList,
        _like = like;

  // studentのアプリでは必要ないと判断
  // 下記の編集権限はteacherIdと一致することを確認する
  // void changeAnswerText(final AnswerText newAnswerText) {
  //   _answerText = newAnswerText;
  // }

  // void changeAnswerPhotoPathList(final AnswerPhotoPathList newAnswerPhotoList) {
  //   _answerPhotoPathList = newAnswerPhotoList;
  // }
}
