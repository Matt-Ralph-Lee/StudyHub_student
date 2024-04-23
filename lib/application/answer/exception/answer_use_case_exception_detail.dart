import '../../shared/exception/use_case_exception_detail.dart';

enum AnswerUseCaseExceptionDetail implements UseCaseExceptionDetail {
  failedImageProcessing('画像の処理に失敗しました。');

  const AnswerUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
