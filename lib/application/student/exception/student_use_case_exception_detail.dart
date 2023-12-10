import '../../shared/exception/use_case_exception_detail.dart';

enum StudentUseCaseExceptionDetail implements UseCaseExceptionDetail {
  notFound('ユーザーが見つかりませんでした'),
  failedInImageProcessing('画像の処理に失敗しました'),
  // nameInvalidLength(
  //     '${StudentName.minLength}字以上${StudentName.maxLength}字以下にしてください'),
  // idInvalidLength('${StudentId.minLength}字以上にしてください'),
  // invalidImagePath('画像パスが不正です'),
  // invalidImageSize(
  //     'プロフィール画像の大きさは${ProfileImage.height}x${ProfileImage.width}にしてください'),
  // empty('Empty is not allowed.'),
  // missingCharacter('Missing specified character to be used.'),
  // invalidCharacter('Invalid character is used.'),
  // alreadyExists('The account already exists.'),
  // cannotConvert('cannot convert data.'),
  ;

  const StudentUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
