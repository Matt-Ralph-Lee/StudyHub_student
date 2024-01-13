import '../../shared/exception/use_case_exception_detail.dart';

enum StudentUseCaseExceptionDetail implements UseCaseExceptionDetail {
  notFound('ユーザーが見つかりませんでした'),
  failedInImageProcessing('画像の処理に失敗しました'),
  ;

  const StudentUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
