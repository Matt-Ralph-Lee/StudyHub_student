import '../../../shared/infrastructure_exception_detail.dart';

enum StudentAuthInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  notFound('ユーザーが見つかりません'),
  ;

  const StudentAuthInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
