import '../exception_detail.dart';

enum StudentAuthProcessExceptionDetail implements ExceptionDetail {
  noCurrentAccount(
    'noCurrentAccountException',
    'There does not exist current Account.',
  ),

  wrongPassword(
    'wrongPasswordException',
    'Password is wrong.',
  ),
  notFound(
    'notFoundException',
    'The account is not found.',
  ),
  ;

  const StudentAuthProcessExceptionDetail(
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
