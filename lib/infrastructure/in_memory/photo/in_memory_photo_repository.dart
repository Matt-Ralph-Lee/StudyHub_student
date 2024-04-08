import 'package:flutter/services.dart';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/photo/models/photo_path_list.dart';
import '../../../domain/shared/profile_photo_path.dart';

class InMemoryPhotoRepository implements IPhotoRepository {
  late Map<PhotoPath, Uint8List> store;
  static final InMemoryPhotoRepository _instance =
      InMemoryPhotoRepository._internal();

  factory InMemoryPhotoRepository() {
    return _instance;
  }

  InMemoryPhotoRepository._internal() {
    store = {};
    rootBundle.load("assets/photos/profile_photo/sample_user_icon.jpg").then(
        (byteData) => store[
                ProfilePhotoPath("photos/profile_photo/sample_user_icon.jpg")] =
            byteData.buffer
                .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    rootBundle.load("assets/photos/profile_photo/sample_user_icon2.jpg").then(
        (byteData) => store[ProfilePhotoPath(
                "photos/profile_photo/sample_user_icon2.jpg")] =
            byteData.buffer
                .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    rootBundle.load("assets/images/sample_picture_hd.jpg").then((byteData) =>
        store[ProfilePhotoPath("photos/sample_picture_hd.jpg")] = byteData
            .buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print("in store");
    print(store);
    print("in store");
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
