// 例外の中身を表すモデル
abstract class ExceptionDetail {
  const ExceptionDetail();

  String get exceptionTitle;
  String get exceptionMessage;
}
