import 'package:image/image.dart';

import '../../exception/student_domain_exception.dart';
import '../../exception/student_domain_exception_detail.dart';
import 'profile_image_path.dart';

class ProfileImage {
  static const height = 180;
  static const width = 180;
  final ProfileImagePath _path;
  final Image _image;

  ProfileImagePath get path => _path;

  ProfileImage({
    required final ProfileImagePath path,
    required final Image image,
  })  : _path = path,
        _image = image {
    _validate(image);
  }

  void _validate(final Image image) {
    if (image.height != height) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidImageSize);
    }
    if (image.width > width) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidImageSize);
    }
  }
}
