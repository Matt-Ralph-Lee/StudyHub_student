import '../../shared/infrastructure_exception_detail.dart';

enum NotificationInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  idAlreadyExist('id already exists'),
  notificationNotFound("notification not found"),
  ;

  const NotificationInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
