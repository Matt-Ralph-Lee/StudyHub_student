import 'package:flutter/material.dart';

import '../../../application/photo/application_service/i_get_photo_query_service.dart';
import '../../../domain/photo/models/photo_path.dart';
import 'in_memory_photo_repository.dart';

class InMemoryGetPhotoQueryService implements IGetPhotoQueryService {
  final InMemoryPhotoRepository _repository;

  InMemoryGetPhotoQueryService(this._repository);

  @override
  Future<ImageProvider> get(PhotoPath photoPath) {
    return _repository.getImageFromPath(photoPath);
  }
}
