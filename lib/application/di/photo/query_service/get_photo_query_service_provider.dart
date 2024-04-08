import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../infrastructure/firebase/photo/firebase_get_photo_query_service.dart";
import "../../../../infrastructure/firebase/photo/firebase_photo_repository.dart";
import "../../../../infrastructure/in_memory/photo/in_memory_get_photo_query_service.dart";
import "../../../../infrastructure/in_memory/photo/in_memory_photo_repository.dart";
import "../../../photo/application_service/i_get_photo_query_service.dart";
import "../../../shared/flavor/flavor.dart";
import "../../../shared/flavor/flavor_config.dart";

part 'get_photo_query_service_provider.g.dart';

@riverpod
IGetPhotoQueryService getPhotoQueryServiceDi(GetPhotoQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetPhotoQueryService(InMemoryPhotoRepository());
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      return FirebaseGetPhotoQueryService(FirebasePhotoRepository());
  }
}
