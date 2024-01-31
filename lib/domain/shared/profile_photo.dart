import 'package:image/image.dart';

import '../photo/models/photo.dart';
import '../photo/models/photo_path.dart';
import '../student/exception/student_domain_exception.dart';
import '../student/exception/student_domain_exception_detail.dart';

class ProfilePhoto extends Photo {
  static const avaliableHeight = 180;
  static const availableWidth = 180;

  ProfilePhoto._(
      {required super.path,
      required super.data,
      required super.height,
      required super.width});

  factory ProfilePhoto.fromImage({
    required final PhotoPath path,
    required final Image image,
  }) {
    final height = image.height;
    final width = image.width;
    final data = encodeJpg(image);
    return ProfilePhoto._(path: path, data: data, height: height, width: width);
  }

  @override
  void validate({required int height, required int width}) {
    if (height != avaliableHeight) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoSize);
    }
    if (width != availableWidth) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
