import 'photo.dart';
import 'photo_path.dart';

abstract class IPhotoRepository {
  void save(final List<Photo> photoList);
  void delete(final PhotoPath photoPath);
}
