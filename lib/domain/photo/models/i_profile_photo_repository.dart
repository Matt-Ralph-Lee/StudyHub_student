import 'photo.dart';
import 'photo_path.dart';

abstract class IPhotoRepository {
  void save(final Photo photo);
  void delete(final PhotoPath photoPath);
}
