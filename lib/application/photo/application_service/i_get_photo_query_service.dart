import 'dart:typed_data';

abstract class IGetPhotoQueryService {
  Uint8List get(final String path);
}
