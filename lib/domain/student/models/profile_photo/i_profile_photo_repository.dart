import 'profile_photo.dart';
import 'profile_photo_path.dart';

abstract class IProfilePhotoRepository {
  void save(final ProfilePhoto profilePhoto);
  void delete(final ProfilePhotoPath profilePhotoPath);
}
