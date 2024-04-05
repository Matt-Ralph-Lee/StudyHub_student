import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/notification/repository/notification_repository_provider.dart";
import "../../../application/notification/application_service/read_notification_use_case.dart";
import "../../../domain/notification/models/notification_id.dart";
import "../check_notification_controller/check_notification_controller.dart";
import "../get_my_notifications_controller/get_my_notifications_controller.dart";

part "read_notification_controller.g.dart";

@riverpod
class ReadNotificationController extends _$ReadNotificationController {
  @override
  Future<void> build() async {}

  Future<void> readNotification(NotificationId notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final notificationRepository = ref.read(notificationRepositoryDiProvider);

      final readNotificationUseCase =
          ReadNotificationUseCase(notificationRepository);

      readNotificationUseCase.execute(notificationId);
    });
    ref.invalidate(checkNotificationControllerProvider);
    ref.invalidate(getMyNotificationsControllerProvider);
  }
}
