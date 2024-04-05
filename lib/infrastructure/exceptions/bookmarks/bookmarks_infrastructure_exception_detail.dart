import '../../shared/infrastructure_exception_detail.dart';

enum BookmarksInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  studentNotFound('student not found'),
  teacherNotFound('teacher not found'),
  ;

  const BookmarksInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
