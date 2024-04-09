import 'package:flutter/material.dart';

import '../../../domain/photo/models/photo_path.dart';
import 'i_get_photo_query_service.dart';

class _PhotoPath extends PhotoPath {
  _PhotoPath(super.value);
  @override
  void validate(String value) {}
}

class GetPhotoUseCase {
  final IGetPhotoQueryService _queryService;

  GetPhotoUseCase(this._queryService);

  Future<ImageProvider> execute(final String photoPathData) async {
    final photoPath = _PhotoPath(photoPathData);

    final image = await _queryService.get(photoPath);

    return image;
  }
}
