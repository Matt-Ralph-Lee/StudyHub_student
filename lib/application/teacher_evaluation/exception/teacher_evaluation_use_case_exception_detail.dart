import '../../shared/exception/use_case_exception_detail.dart';

enum EvaluationUseCaseExceptionDetail implements UseCaseExceptionDetail {
  favoriteTeacherNotFound('Evaluationが見つかりませんでした。');

  const EvaluationUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
