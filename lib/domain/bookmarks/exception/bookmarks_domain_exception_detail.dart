import '../../shared/domain_exception_detail.dart';
import '../models/bookmarks.dart';

enum BookmarksDomainExceptionDetail implements DomainExceptionDetail {
  invalidQuestionLength('質問の数が多すぎます。${Bookmarks.maxLength}個以内にしてください。'),
  duplicateQuestion("同じ質問が選択されています。"),
  questionNotFound("質問が見つかりませんでした。");

  const BookmarksDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
