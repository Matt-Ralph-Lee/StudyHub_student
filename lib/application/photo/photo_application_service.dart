import 'dart:io';
import 'package:image/image.dart';
import 'package:studyhub/domain/photo/models/photo_file_format.dart';
import 'package:uuid/uuid.dart';

import '../../domain/photo/models/i_photo_repository.dart';
import '../../domain/photo/models/photo.dart';

class PhotoApplicationService {
  final IPhotoRepository _repository;

  PhotoApplicationService({required final repository})
      : _repository = repository;

  void upload(final String localPath) {
    final decodedImage = decodeImage(File(localPath).readAsBytesSync());
    final fileExtension = localPath.split('.').last;
    if (fileExtension != PhotoFileFormat.jpg.name &&
        fileExtension != PhotoFileFormat.jpeg.name) {
      final path = localPath.replaceAll(
          '.$fileExtension', '.${PhotoFileFormat.jpg.name}');
    }

    ref.putFile(decodedImage);
  }
}
