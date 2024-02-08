import '../../shared/domain_exception.dart';
import 'blockings_domain_exception_detail.dart';

class BlockingsDomainException extends DomainException {
  const BlockingsDomainException(
    BlockingsDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
