import '../../shared/exception/use_case_exception_detail.dart';

enum FavoriteTeachersUseCaseExceptionDetail implements UseCaseExceptionDetail {
  favoriteTeacherNotFound('FavoriteTeachersが見つかりませんでした。');

  const FavoriteTeachersUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
