import '../../shared/infrastructure_exception.dart';
import 'student_infrastructure_exception_detail.dart';

class StudentInfrastructureException extends InfrastructureException {
  const StudentInfrastructureException(
    StudentInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
