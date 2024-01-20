import '../../shared/domain_exception_detail.dart';
import '../models/answer_id.dart';
import '../models/answer_photo.dart';
import '../models/answer_photo_path_list.dart';
import '../models/answer_text.dart';

enum AnswerDomainExceptionDetail implements DomainExceptionDetail {
  idInvalidLength('${AnswerId.minLength}字以上にしてください。'),
  textEmptyLength('文字列が空です。質問を入力してください。'),
  textInvalidLength('${AnswerText.maxLength}字以上にしてください。'),
  invalidPhotoPath('画像パスが不正です'),
  invalidPhotoSize(
      'プロフィール画像の大きさは${AnswerPhoto.height}x${AnswerPhoto.width}にしてください'),
  invalidPhotoLength('画像は${AnswerPhotoPathList.maxLength}枚までです。'),
  // invalidQuestionCount('質問数が不正です'),
  ;

  const AnswerDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
