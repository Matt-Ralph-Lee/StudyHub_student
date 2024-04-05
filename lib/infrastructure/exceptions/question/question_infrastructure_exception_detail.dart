import '../../shared/infrastructure_exception_detail.dart';

enum QuestionInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  studentNotFound('student not found'),
  teacherNotFound('teacher not found'),
  questionNotFound('question not found'),
  ;

  const QuestionInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
