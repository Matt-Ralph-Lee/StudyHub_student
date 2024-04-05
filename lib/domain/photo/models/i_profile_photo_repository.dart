import 'photo.dart';
import 'photo_path.dart';
import 'photo_path_list.dart';

abstract class IPhotoRepository {
  Future<void> save(final List<Photo> photoList);
  Future<void> delete(final PhotoPath photoPath);
  Future<void> deleteList(final PhotoPathList photoPathList);
}
