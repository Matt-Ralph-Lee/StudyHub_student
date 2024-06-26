import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/notification/query_service/notification_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/notification/application_service/get_my_notification_dto.dart";
import "../../../application/notification/application_service/get_my_notifications_use_case.dart";

part "get_my_notifications_controller.g.dart";

@riverpod
class GetMyNotificationsController extends _$GetMyNotificationsController {
  @override
  Future<List<GetMyNotificationDto>> build() async {
    final session = ref.read(nonNullSessionProvider);
    final queryService = ref.watch(getMyNotificationsQueryServiceDiProvider);
    final logger = ref.read(loggerDiProvider);

    final getMyNotificationsUseCase = GetMyNotificationsUseCase(
      session: session,
      queryService: queryService,
      logger: logger,
    );

    final getMyNotificationDto = getMyNotificationsUseCase.execute();
    return getMyNotificationDto;
  }
}
