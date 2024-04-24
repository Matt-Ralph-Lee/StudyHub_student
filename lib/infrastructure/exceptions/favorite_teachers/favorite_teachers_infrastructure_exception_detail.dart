import '../../shared/infrastructure_exception_detail.dart';

enum FavoriteTeachersInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  // studentDataNotFound('student data not found'),
  // studentNotFound('student not found'),
  // noPassword('password is not set'),
  // wrongEmailOrPassword('メールアドレスまたはパスワードが違います'),
  docNotFound('firebase error: document not found'),
  ;

  const FavoriteTeachersInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
