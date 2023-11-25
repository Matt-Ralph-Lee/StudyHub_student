import 'photo.dart';

abstract class IPhotoRepository {
  void save(final Photo photo);
  void delete(Photo photo);
  Photo find(Photo localPhoto);
}
