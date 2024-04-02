import 'package:flutter/services.dart';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/photo/models/photo_path_list.dart';
import '../../../domain/shared/profile_photo_path.dart';
import 'exception/photo_infrastructure_exception.dart';
import 'exception/photo_infrastructure_exception_detail.dart';

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
  void save(List<Photo> photoList) {
    for (Photo photo in photoList) {
      store[photo.path] = photo.data;
    }
  }

  @override
  void delete(PhotoPath photoPath) {
    store.remove(photoPath);
  }

  @override
  void deleteList(PhotoPathList photoPathList) {
    for (var photoPath in photoPathList) {
      store.remove(photoPath);
    }
  }

  @override
  Uint8List get(PhotoPath photoPath) {
    final photo = store[photoPath];
    if (photo == null) {
      throw const PhotoInfrastructureException(
          PhotoInfrastructureExceptionDetail.photoNotFound);
    }

    return photo;
  }
}
