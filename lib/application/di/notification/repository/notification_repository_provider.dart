import "package:riverpod_annotation/riverpod_annotation.dart";

import '../../../../domain/notification/models/i_notification_repository.dart';
import '../../../../infrastructure/in_memory/notification/in_memory_notification_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'notification_repository_provider.g.dart';

@riverpod
INotificationRepository notificationRepositoryDi(
    NotificationRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryNotificationRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
