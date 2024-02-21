import '../../../shared/infrastructure_exception.dart';
import 'bookmarks_domain_exception_detail.dart';

class BookmarksInfrastructureException extends InfrastructureException {
  const BookmarksInfrastructureException(
    BookmarksInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
