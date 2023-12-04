import 'package:uuid/uuid.dart';

import '../../domain/photo/models/i_photo_repository.dart';
import '../../domain/photo/models/photo.dart';
import '../../domain/photo/models/photo_id.dart';
import '../../domain/photo/models/photo_path.dart';

class PhotoApplicationService {
  final IPhotoRepository _repository;

  PhotoApplicationService({required final repository})
      : _repository = repository;

  void register(final String localPath) {
    final photoPath = PhotoPath(localPath);
    final photo = Photo(photoId: photoId, path: photoPath);
    _repository.save(photo);
  }
}