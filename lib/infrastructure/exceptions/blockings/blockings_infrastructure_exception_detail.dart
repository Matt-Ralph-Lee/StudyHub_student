import '../../shared/infrastructure_exception_detail.dart';

enum BlockingsInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  studentNotFound('student not found'),
  ;

  const BlockingsInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
