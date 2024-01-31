import '../../shared/domain_exception.dart';
import 'student_domain_exception_detail.dart';

class StudentDomainException extends DomainException {
  const StudentDomainException(
    StudentDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
