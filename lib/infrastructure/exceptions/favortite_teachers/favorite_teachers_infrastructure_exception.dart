import '../../shared/infrastructure_exception.dart';
import 'favorite_teachers_infrastructure_exception_detail.dart';

class FavoriteTeachersInfrastructureException extends InfrastructureException {
  const FavoriteTeachersInfrastructureException(
    FavoriteTeachersInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
