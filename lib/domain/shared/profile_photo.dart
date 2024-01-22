import 'package:image/image.dart';

import '../photo/models/photo.dart';
import '../student/exception/student_domain_exception.dart';
import '../student/exception/student_domain_exception_detail.dart';

class ProfilePhoto extends Photo {
  static const height = 180;
  static const width = 180;

  ProfilePhoto({required super.path, required super.image});

  @override
  void validate(final Image image) {
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
