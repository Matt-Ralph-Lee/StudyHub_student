import '../../shared/domain_exception_detail.dart';

enum BlockingsDomainExceptionDetail implements DomainExceptionDetail {
  duplicateTeacher("同じ先生が選択されています。"),
  teacherNotFound("先生が見つかりませんでした。");

  const BlockingsDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
