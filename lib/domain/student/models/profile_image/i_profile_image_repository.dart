import 'profile_image.dart';
import 'profile_image_path.dart';

abstract class IProfileImageRepository {
  void save(final ProfileImage profileImage);
  void delete(final ProfileImagePath profileImagePath);
}
