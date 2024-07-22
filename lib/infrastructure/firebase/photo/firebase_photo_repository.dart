import "package:firebase_storage/firebase_storage.dart";
import 'package:flutter/material.dart';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/photo/models/photo_path_list.dart';

class FirebasePhotoRepository implements IPhotoRepository {
  final storageRef = FirebaseStorage.instance.ref();

  static final FirebasePhotoRepository _instance =
      FirebasePhotoRepository._internal();

  factory FirebasePhotoRepository() {
    return _instance;
  }

  FirebasePhotoRepository._internal();

  @override
  Future<void> delete(PhotoPath photoPath) async {
    final imageRef = storageRef.child(photoPath.value);
    await imageRef.delete();
  }

  @override
  Future<void> deleteList(PhotoPathList photoPathList) async {
    for (final photoPath in photoPathList) {
      final imageRef = storageRef.child(photoPath.value);
      await imageRef.delete();
    }
  }

  @override
  Future<void> save(List<Photo> photoList) async {
    for (final photo in photoList) {
      final imageRef = storageRef.child(photo.path.value);

      final metaData = SettableMetadata(contentType: "image/jpg");

      await imageRef.putData(photo.data, metaData);
    }
  }

  @override
  Future<ImageProvider> getImageFromPath(PhotoPath photoPath) async {
    if (photoPath.value.contains("assets")) {
      return AssetImage(photoPath.value);
    }
    final imageUrl = await storageRef.child(photoPath.value).getDownloadURL();
    return NetworkImage(imageUrl);
  }
}
