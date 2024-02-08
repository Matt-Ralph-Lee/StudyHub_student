import '../../shared/exception/use_case_exception.dart';
import 'bookmarks_use_case_exception_detail.dart';

class BookmarksUseCaseException extends UseCaseException {
  const BookmarksUseCaseException(
    BookmarksUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
