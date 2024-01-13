import 'package:image/image.dart';

import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/photo/models/photo.dart';
import '../../../domain/photo/models/photo_path.dart';

class InMemoryPhotoRepository implements IPhotoRepository {
  final store = <PhotoPath, Image>{};

  @override
  void delete(PhotoPath photoPath) {
    store.remove(photoPath);
  }

  @override
  void save(Photo photo) {
    store[photo.path] = photo.image;
  }
}
