import '../../shared/domain_exception.dart';
import 'favorite_teachers_domain_exception_detail.dart';

class FavoriteTeachersDomainException extends DomainException {
  const FavoriteTeachersDomainException(
    FavoriteTeachersDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
