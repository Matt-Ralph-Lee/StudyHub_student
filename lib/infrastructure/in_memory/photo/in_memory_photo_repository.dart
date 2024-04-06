import 'dart:typed_data';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/photo/models/photo_path_list.dart';

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
}
