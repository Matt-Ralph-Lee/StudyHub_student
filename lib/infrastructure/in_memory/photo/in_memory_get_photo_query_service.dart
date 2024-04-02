import 'dart:typed_data';

import '../../../application/photo/application_service/i_get_photo_query_service.dart';
import '../../../domain/photo/models/photo_path.dart';
import 'in_memory_photo_repository.dart';

class _PhotoPath extends PhotoPath {
  @override
  void validate(String value) {}

  _PhotoPath(super._value);
}

class InMemoryGetPhotoQueryService implements IGetPhotoQueryService {
  final InMemoryPhotoRepository _repository;

  InMemoryGetPhotoQueryService(this._repository);

  @override
  Uint8List get(String path) {
    final photoPath = _PhotoPath(path);

    final photo = _repository.get(photoPath);

    return photo;
  }
}
