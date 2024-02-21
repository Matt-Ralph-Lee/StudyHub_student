import '../../shared/domain_exception.dart';
import 'bookmarks_domain_exception_detail.dart';

class BookmarksDomainException extends DomainException {
  const BookmarksDomainException(
    BookmarksDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
