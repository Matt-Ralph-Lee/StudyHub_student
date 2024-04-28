import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../domain/notification/models/i_notification_factory.dart";
import "../../../../infrastructure/firebase/notification/firebase_notification_factory.dart";
import "../../../../infrastructure/firebase/notification/firebase_notification_repository.dart";
import "../../../../infrastructure/in_memory/notification/in_memory_notification_factory.dart";
import "../../../../infrastructure/in_memory/notification/in_memory_notification_repository.dart";
import "../../../shared/flavor/flavor.dart";
import "../../../shared/flavor/flavor_config.dart";

part 'notification_factory_provider.g.dart';

@riverpod
INotificationFactory notificationFactoryDi(NotificationFactoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryNotificationFactory(
          repository: InMemoryNotificationRepository());
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseNotificationFactory(FirebaseNotificationRepository());
  }
}
