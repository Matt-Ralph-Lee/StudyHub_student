import '../exception_detail.dart';

enum AccountProcessExceptionDetail implements ExceptionDetail {

  noCurrentUser(
    'noCurrentUserException',
    'There does not exist current user.',
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

  const AccountProcessExceptionDetail(
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
