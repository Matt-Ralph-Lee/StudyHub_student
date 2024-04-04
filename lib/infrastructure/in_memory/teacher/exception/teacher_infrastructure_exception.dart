import '../../../shared/infrastructure_exception.dart';
import 'teacher_infrastructure_exception_detail.dart';

class TeacherInfrastructureException extends InfrastructureException {
  const TeacherInfrastructureException(
    TeacherInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
