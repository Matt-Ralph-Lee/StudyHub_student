import 'package:flutter/material.dart';

import '../../../application/photo/application_service/i_get_photo_query_service.dart';
import '../../../domain/photo/models/photo_path.dart';
import 'firebase_photo_repository.dart';

class FirebaseGetPhotoQueryService implements IGetPhotoQueryService {
  final FirebasePhotoRepository _repository;

  FirebaseGetPhotoQueryService(this._repository);

  @override
  Future<ImageProvider> get(PhotoPath photoPath) {
    return _repository.getImageFromPath(photoPath);
  }
}
