import 'package:image/image.dart';

import '../../exception/student_domain_exception.dart';
import '../../exception/student_domain_exception_detail.dart';
import 'profile_photo_path.dart';

class ProfilePhoto {
  static const height = 180;
  static const width = 180;
  final ProfilePhotoPath _path;
  final Image _image;

  ProfilePhotoPath get path => _path;

  ProfilePhoto({
    required final ProfilePhotoPath path,
    required final Image image,
  })  : _path = path,
        _image = image {
    _validate(image);
  }

  void _validate(final Image image) {
    if (image.height != height) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoSize);
    }
    if (image.width > width) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
