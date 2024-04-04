import "package:riverpod_annotation/riverpod_annotation.dart";

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
    if (session == null) {
      throw Exception('Session is null');
    }

    final getMyNotificationsUseCase = GetMyNotificationsUseCase(
      session: session,
      queryService: queryService,
    );

    final getMyNotificationDto = getMyNotificationsUseCase.execute();
    return getMyNotificationDto;
  }
}
