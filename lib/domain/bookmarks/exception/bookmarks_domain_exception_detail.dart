import '../../shared/domain_exception_detail.dart';

enum BookmarksDomainExceptionDetail implements DomainExceptionDetail {
  duplicateQuestion("同じ質問が選択されています。"),
  questionNotFound("質問が見つかりませんでした。");

  const BookmarksDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
