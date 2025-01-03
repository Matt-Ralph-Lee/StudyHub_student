import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/firebase/notification/firebase_get_my_notifications_query_service.dart';
import '../../../../infrastructure/in_memory/notification/in_memory_get_my_notifications_query_service.dart';
import '../../../../infrastructure/in_memory/notification/in_memory_notification_repository.dart';
import '../../../notification/application_service/i_get_my_notifications_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../repository/notification_repository_provider.dart';

part 'notification_query_service_provider.g.dart';

@riverpod
IGetMyNotificationsQueryService getMyNotificationsQueryServiceDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetMyNotificationsQueryService(
        repository: (ref.watch(notificationRepositoryDiProvider))
            as InMemoryNotificationRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseGetMyNotificationsQueryService();
  }
}
