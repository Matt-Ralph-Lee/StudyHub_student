import 'dart:typed_data';

import 'i_get_photo_query_service.dart';

class GetPhotoUseCase {
  final IGetPhotoQueryService _queryService;

  GetPhotoUseCase(this._queryService);

  Uint8List execute(final String photoPath) {
    final photo = _queryService.get(photoPath);

    return photo;
  }
}
