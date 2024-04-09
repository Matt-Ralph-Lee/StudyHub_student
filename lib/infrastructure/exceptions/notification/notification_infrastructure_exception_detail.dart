import '../../shared/infrastructure_exception_detail.dart';

enum NotificationInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  idAlreadyExist('id already exists'),
  invalidReceiverType("recevier type is invalid"),
  invalidSenderType("sender type is invalid"),
  invalidTargetType("target type is invalid"),
  notificationNotFound("notification not found"),
  ;

  const NotificationInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
