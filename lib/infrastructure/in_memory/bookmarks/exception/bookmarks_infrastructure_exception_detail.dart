import '../../../shared/infrastructure_exception_detail.dart';

enum BookmarksInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  studentNotFound("生徒が見つかりませんでした。");

  const BookmarksInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
