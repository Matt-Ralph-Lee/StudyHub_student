import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import 'get_my_notification_dto.dart';
import 'i_get_my_notifications_query_service.dart';

class GetMyNotificationsUseCase {
  final Session _session;
  final IGetMyNotificationsQueryService _queryService;
  final ILogger _logger;

  GetMyNotificationsUseCase({
    required final Session session,
    required final IGetMyNotificationsQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<GetMyNotificationDto>> execute() async {
    _logger.info('BEGIN $GetMyNotificationsUseCase.execute()');

    final studentId = _session.studentId;
    final notificationList = await _queryService.get(studentId);

    _logger.info('END $GetMyNotificationsUseCase.execute()');
    return notificationList;
  }
}
