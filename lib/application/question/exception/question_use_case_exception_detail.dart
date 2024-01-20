import '../../shared/exception/use_case_exception_detail.dart';

enum QuestionUseCaseExceptionDetail implements UseCaseExceptionDetail {
  failDeleting('Questionを削除する権限がありません。'),
  failEditing('Questionを編集する権限がありません。'),
  questionNotFound('Questionが見つかりません。'),
  imageNotFound('画像が見つかりませんでした。'),
  failedImageProcessing('画像の処理に失敗しました。');

  const QuestionUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
