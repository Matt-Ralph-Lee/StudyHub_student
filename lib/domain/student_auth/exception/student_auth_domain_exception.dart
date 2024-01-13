import '../../shared/domain_exception.dart';
import 'student_auth_domain_exception_detail.dart';

class StudentAuthDomainException extends DomainException {
  const StudentAuthDomainException(
    StudentAuthDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
