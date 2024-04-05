import '../../shared/infrastructure_exception_detail.dart';

enum AnswerInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  answerNotFound('answer not found'),
  ;

  const AnswerInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
