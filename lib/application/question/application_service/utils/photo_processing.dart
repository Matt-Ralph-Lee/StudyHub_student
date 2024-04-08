import 'dart:io';

import 'package:image/image.dart';

import '../../../../domain/question/models/question_photo.dart';
import '../../../../domain/question/models/question_photo_path.dart';
import '../../../../domain/question/models/question_photo_path_list.dart';
import '../../../../domain/student/models/student_id.dart';
import '../../exception/question_use_case_exception.dart';
import '../../exception/question_use_case_exception_detail.dart';

QuestionPhotoPath createPath(final String fileName) {
  return QuestionPhotoPath('images/$fileName.jpg');
}

QuestionPhotoPathList createPathListFromId({
  required final StudentId studentId,
  required final List<String> localPathList,
}) {
  final questionPhotoPathListData = <QuestionPhotoPath>[];

  final now = DateTime.now();
  final year = now.year;
  final month = now.month;
  final date = now.day;
  final hour = now.hour;
  final minute = now.minute;
  final second = now.second;
  final prefix =
      '${studentId.value}-$year-${month.toString().padLeft(2, '0')}-${date.toString().padLeft(2, '0')}-${hour.toString().padLeft(2, '0')}-${minute.toString().padLeft(2, '0')}-${second.toString().padLeft(2, '0')}';

  for (var i = 0; i < localPathList.length; i++) {
    final fileName = '$prefix-${i.toString().padLeft(2, '0')}';
    final questionPhotoPath = createPath(fileName);
    questionPhotoPathListData.add(questionPhotoPath);
  }

  return QuestionPhotoPathList(questionPhotoPathListData);
}

List<Image> resizeAndConvertToJpgForMultiplePhoto(List<String> localPathList) {
  const sizeThresholdBytes = QuestionPhoto.dataSize;

  final processedPhotoList = <Image>[];

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

        processedPhotoList.add(resizedImage);
      } else {
        processedPhotoList.add(image);
      }
    } else {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.imageNotFound);
    }
  }

  return processedPhotoList;
}
