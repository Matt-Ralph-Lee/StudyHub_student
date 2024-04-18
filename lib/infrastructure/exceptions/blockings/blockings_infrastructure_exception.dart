import '../../shared/infrastructure_exception.dart';
import 'blockings_infrastructure_exception_detail.dart';

class BlockingsInfrastructureException extends InfrastructureException {
  const BlockingsInfrastructureException(
    BlockingsInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
