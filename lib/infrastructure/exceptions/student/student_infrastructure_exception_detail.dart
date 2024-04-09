import '../../shared/infrastructure_exception_detail.dart';

enum StudentInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  studentNotFound('student not found'),
  ;

  const StudentInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
