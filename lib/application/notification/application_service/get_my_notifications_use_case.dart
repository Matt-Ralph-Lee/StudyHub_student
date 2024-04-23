import '../../shared/session/session.dart';
import 'get_my_notification_dto.dart';
import 'i_get_my_notifications_query_service.dart';

class GetMyNotificationsUseCase {
  final Session _session;
  final IGetMyNotificationsQueryService _queryService;

  GetMyNotificationsUseCase({
    required final Session session,
    required final IGetMyNotificationsQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  Future<List<GetMyNotificationDto>> execute() async {
    final studentId = _session.studentId;
    final notificationList = await _queryService.get(studentId);
    return notificationList;
  }
}
