import '../../shared/exception/use_case_exception_detail.dart';

enum QuestionUseCaseExceptionDetail implements UseCaseExceptionDetail {
  failedDeleting('Questionを削除する権限がありませんでした。'),
  failedEditing('Questionを編集する権限がありませんでした。'),
  questionNotFound('Questionが見つかりません。'),
  imageNotFound('画像が見つかりませんでした。'),
  failedImageProcessing('画像の処理に失敗しました。'),
  notAllowedToResolve('Not allowed to resolve this question'),
  ;

  const QuestionUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
