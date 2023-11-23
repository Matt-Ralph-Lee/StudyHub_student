import 'exception_detail.dart';

enum UnknownExceptionDetail implements ExceptionDetail {
  unknown('unknownException', 'unexpected exception has occured.');

  const UnknownExceptionDetail(
    this._exceptionTitle,
    this._exceptionMessage,
  );

  final String _exceptionTitle;
  final String _exceptionMessage;

  @override
  String get exceptionTitle => _exceptionTitle;

  @override
  String get exceptionMessage => _exceptionMessage;
}
