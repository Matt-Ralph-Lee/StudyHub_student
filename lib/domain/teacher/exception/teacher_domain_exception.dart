import '../../shared/domain_exception.dart';
import 'teacher_domain_exception_detail.dart';

class TeacherDomainException extends DomainException {
  const TeacherDomainException(
    TeacherDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
