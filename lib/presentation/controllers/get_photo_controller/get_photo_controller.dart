import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/photo/query_service/get_photo_query_service_provider.dart";
import "../../../application/photo/application_service/get_photo_use_case.dart";

part 'get_photo_controller.g.dart';

@riverpod
class GetPhotoController extends _$GetPhotoController {
  @override
  Future<ImageProvider> build(final String photoPathData) async {
    final queryService = ref.read(getPhotoQueryServiceDiProvider);

    final getPhotoUseCase = GetPhotoUseCase(queryService);

    final image = await getPhotoUseCase.execute(photoPathData);

    return image;
  }
}
