import '../../shared/exception/use_case_exception.dart';
import 'favorite_teachers_use_case_exception_detail.dart';

class FavoriteTeachersUseCaseException extends UseCaseException {
  const FavoriteTeachersUseCaseException(
    FavoriteTeachersUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
