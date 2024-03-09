import 'dart:io';

import 'package:image/image.dart';

import '../../../../domain/shared/profile_photo.dart';
import '../../../../domain/shared/profile_photo_path.dart';
import '../../../../domain/student/models/student_id.dart';
import '../../exception/student_use_case_exception.dart';
import '../../exception/student_use_case_exception_detail.dart';

ProfilePhotoPath createPathFromId(final StudentId studentId) {
  final fileName = createFileName(studentId);
  return createPath(fileName);
}

ProfilePhotoPath createPath(final String fileName) {
  return ProfilePhotoPath('photos/profile_photo/$fileName.jpeg');
}

String createFileName(final StudentId studentId) {
  final now = DateTime.now();

  final year = now.year;
  final month = now.month;
  final date = now.day;
  final hour = now.hour;
  final minute = now.minute;
  final second = now.second;
  final fileName =
      '${studentId.value}-$year-${month.toString().padLeft(2, '0')}-${date.toString().padLeft(2, '0')}-${hour.toString().padLeft(2, '0')}-${minute.toString().padLeft(2, '0')}-${second.toString().padLeft(2, '0')}';
  return fileName;
}

Image convertToJpegAndResize(String localPhotoPath) {
  final file = File(localPhotoPath);

  if (file.existsSync()) {
    final originalImageBytes = file.readAsBytesSync();
    final image = decodeImage(originalImageBytes);
    if (image == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.failedInImageProcessing);
    }

    final croppedImage =
        copyResizeCropSquare(image, size: ProfilePhoto.avaliableHeight);

    return croppedImage;
  } else {
    throw const StudentUseCaseException(
        StudentUseCaseExceptionDetail.photoNotFound);
  }
}
