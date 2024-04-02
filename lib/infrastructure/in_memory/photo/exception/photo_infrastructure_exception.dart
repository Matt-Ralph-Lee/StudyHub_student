import '../../../shared/infrastructure_exception.dart';
import 'photo_infrastructure_exception_detail.dart';

class PhotoInfrastructureException extends InfrastructureException {
  const PhotoInfrastructureException(
    PhotoInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
