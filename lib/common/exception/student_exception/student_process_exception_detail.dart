import '../exception_detail.dart';

enum StudentProcessExceptionDetail implements ExceptionDetail {
  noCurrentStudent(
    'noCurrentStudentException',
    'There does not exist current Student.',
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

  const StudentProcessExceptionDetail(
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
