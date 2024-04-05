import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/notification/repository/notification_repository_provider.dart";
import "../../../application/notification/application_service/check_notification_existence_use_case.dart";

part "check_notification_controller.g.dart";

@riverpod
class CheckNotificationController extends _$CheckNotificationController {
  @override
  Future<bool> build() async {
    final notificationRepository = ref.read(notificationRepositoryDiProvider);

    final checkNotificationUseCase =
        CheckNotificationExistenceUseCase(notificationRepository);

    final isNotificationRead = checkNotificationUseCase.execute();
    return isNotificationRead;
  }
}
