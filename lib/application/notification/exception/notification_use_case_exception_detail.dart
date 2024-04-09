import '../../shared/exception/use_case_exception_detail.dart';

enum NotificationUseCaseExceptionDetail implements UseCaseExceptionDetail {
  invalidDtoConstruction('invalid dto construction'),
  ;

  const NotificationUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
