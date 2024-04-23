import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/photo/models/photo_path_list.dart';
import '../../exceptions/photo/photo_infrastructure_exception.dart';
import '../../exceptions/photo/photo_infrastructure_exception_detail.dart';

class InMemoryPhotoRepository implements IPhotoRepository {
  late Map<PhotoPath, Uint8List> store;
  static final InMemoryPhotoRepository _instance =
      InMemoryPhotoRepository._internal();

  factory InMemoryPhotoRepository() {
    return _instance;
  }

  InMemoryPhotoRepository._internal() {
    store = {};
  }

  @override
  Future<void> save(List<Photo> photoList) async {
    for (Photo photo in photoList) {
      store[photo.path] = photo.data;
    }
  }

  @override
  Future<void> delete(PhotoPath photoPath) async {
    store.remove(photoPath);
  }

  @override
  Future<void> deleteList(PhotoPathList photoPathList) async {
    for (var photoPath in photoPathList) {
      store.remove(photoPath);
    }
  }

  @override
  Future<ImageProvider> getImageFromPath(PhotoPath photoPath) async {
    if (photoPath.value.contains("assets")) {
      return AssetImage(photoPath.value);
    }
    final image = store[photoPath];
    if (image == null) {
      throw const PhotoInfrastructureException(
          PhotoInfrastructureExceptionDetail.photoNotFound);
    }
    return MemoryImage(image);
  }
}
