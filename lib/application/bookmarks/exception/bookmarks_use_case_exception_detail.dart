import '../../shared/exception/use_case_exception_detail.dart';

enum BookmarksUseCaseExceptionDetail implements UseCaseExceptionDetail {
  bookmarksNotFound('Bookmarksが見つかりませんでした。');

  const BookmarksUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
