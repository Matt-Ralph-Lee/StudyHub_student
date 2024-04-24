import '../../shared/infrastructure_exception_detail.dart';

enum StudentAuthInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  notSignedIn('not signed in'),
  emailAddressAlreadyInUse('email address already in use'),
  invalidEmailAddress('invalid email address'),
  weakPassword('weak password'),
  noRecentSignIn('no recent sign-in'),
  studentNotFound('student not found'),
  studentDisabled('student disabled'),
  wrongPassword('wrong password'),
  invalidCredential('invalid credential'),
  // studentDataNotFound('student data not found'),
  // studentNotFound('student not found'),
  // noPassword('password is not set'),
  // wrongEmailOrPassword('メールアドレスまたはパスワードが違います'),
  unexpected('unexpected error has occured'),
  ;

  const StudentAuthInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
