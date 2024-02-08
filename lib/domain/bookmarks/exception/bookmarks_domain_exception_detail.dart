import '../../shared/domain_exception_detail.dart';
import '../models/bookmarks.dart';

enum BookmarksDomainExceptionDetail implements DomainExceptionDetail {
  invalidQuestionLength('先生の数が多すぎます。${Bookmarks.maxLength}人以内にしてください。'),
  duplicateQuestion("同じ先生が選択されています。"),
  questionNotFound("先生が見つかりませんでした。");

  const BookmarksDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
