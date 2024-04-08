import '../../shared/infrastructure_exception_detail.dart';

enum TeacherInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  ratingNotFound('rating not found'),
  teacherNotFound('teacher not found'),
  docNotFound("firebase error: document not found"),
  ;

  const TeacherInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
