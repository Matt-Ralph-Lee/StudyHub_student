import '../../shared/exception/use_case_exception_detail.dart';

enum FavoriteTeachersUseCaseExceptionDetail implements UseCaseExceptionDetail {
  failedDeleting('FavoriteTeachersを削除する権限がありませんでした。');

  const FavoriteTeachersUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
