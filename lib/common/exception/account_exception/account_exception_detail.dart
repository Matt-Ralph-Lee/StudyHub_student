import '../exception_detail.dart';

enum AccountExceptionDetail implements ExceptionDetail {
  alreadyExistException(
    'alreadyexistException',
    'The account already exists.',
  ),
  ;

  const AccountExceptionDetail(
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
