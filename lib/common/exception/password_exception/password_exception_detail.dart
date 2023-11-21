import '../exception_detail.dart';

enum PasswordExceptionDetail implements ExceptionDetail {
  shortException(
    'shortException',
    'The password is short.',
  ),
  ;

  const PasswordExceptionDetail(
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
