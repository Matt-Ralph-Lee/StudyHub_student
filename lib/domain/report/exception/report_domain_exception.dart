import '../../shared/domain_exception.dart';
import 'report_domain_exception_detail.dart';

class ReportDomainException extends DomainException {
  const ReportDomainException(
    ReportDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
