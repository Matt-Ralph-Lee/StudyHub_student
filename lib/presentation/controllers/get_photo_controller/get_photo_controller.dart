import "dart:typed_data";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/photo/query_service/get_photo_query_service_provider.dart";
import "../../../application/photo/application_service/get_photo_use_case.dart";

part "get_photo_controller.g.dart";

@riverpod
class GetPhotoController extends _$GetPhotoController {
  @override
  Future<Uint8List> build(final String path) async {
    final queryService = ref.watch(getPhotoQueryServiceDiProvider);

    final getPhotoUseCase = GetPhotoUseCase(queryService);

    final photo = getPhotoUseCase.execute(path);

    return photo;
  }
}
