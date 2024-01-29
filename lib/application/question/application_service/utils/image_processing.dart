import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

import '../../../../domain/question/models/question_photo.dart';
import '../../../../domain/question/models/question_photo_path.dart';
import '../../../../domain/student/models/student_id.dart';
import '../../exception/question_use_case_exception.dart';
import '../../exception/question_use_case_exception_detail.dart';

List<QuestionPhotoPath> createPathList(
    final StudentId studentId, final List<String> localPathList) {
  List<QuestionPhotoPath> questionPhotoPathListData = [];

  final now = DateTime.now();

  for (var i = 0; i < localPathList.length; i++) {
    final year = now.year;
    final month = now.month;
    final date = now.day;
    final hour = now.hour;
    final minute = now.minute;
    final second = now.second;
    final fileName =
        '${studentId.value}-$year-${month.toString().padLeft(2, '0')}-${date.toString().padLeft(2, '0')}-${hour.toString().padLeft(2, '0')}-${minute.toString().padLeft(2, '0')}-${second.toString().padLeft(2, '0')}-${i.toString().padLeft(2, '0')}';
    final path = "photos/question_photo/$fileName.jpg";
    questionPhotoPathListData.add(QuestionPhotoPath(path));
  }

  return questionPhotoPathListData;
}

List<Uint8List> resizeAndConvertToJpgForMultiplePhoto(
    List<String> localPathList) {
  const sizeThresholdBytes = QuestionPhoto.dataSize;

  List<Uint8List> processedPhotoList = [];

  for (String localPath in localPathList) {
    final file = File(localPath);
    if (file.existsSync()) {
      final originalImageBytes = file.readAsBytesSync();
      final image = decodeImage(originalImageBytes);
      if (image == null) {
        throw const QuestionUseCaseException(
            QuestionUseCaseExceptionDetail.failedImageProcessing);
      }

      if (image.length > sizeThresholdBytes) {
        final newWidth =
            (image.width * sizeThresholdBytes / image.length).round();
        final newHeight =
            (image.height * sizeThresholdBytes / image.length).round();

        final resizedImage =
            copyResize(image, width: newWidth, height: newHeight);

        processedPhotoList.add(encodeJpg(resizedImage));
      } else {
        processedPhotoList.add(encodeJpg(image));
      }
    } else {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.imageNotFound);
    }
  }

  return processedPhotoList;
}
