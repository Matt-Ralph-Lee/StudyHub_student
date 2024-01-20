import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

import 'package:studyhub/domain/photo/models/i_profile_photo_repository.dart';
import 'package:studyhub/domain/question/models/question_photo_path_list.dart';

import 'question_edit_command.dart';

import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';

import '../../shared/session/i_session.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/question_photo_path.dart';

class QuestionEditUseCase {
  final ISession _session;
  final IQuestionRepository _repository;
  final IPhotoRepository _photoRepository;

  QuestionEditUseCase({
    required final ISession session,
    required final IQuestionRepository repository,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _photoRepository = photoRepository;

  void execute(QuestionEditCommand command) {
    final StudentId studentId = _session.studentId;
    final QuestionId questionId = QuestionId(command.questionId);
    final Question? question = _repository.findById(questionId);

    if (question == null) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.questionNotFound);
    }

    if (question.canEdit(studentId) == false) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.failEditing);
    }

    final newTitle = command.questionTitleData;
    final newText = command.questionTextData;
    final newLocalPathList = command.localPathList;

    if (newTitle != null) {
      question.changeQuestionTitle(QuestionTitle(newTitle));
    }

    if (newText != null) {
      question.changeQuestionText(QuestionText(newText));
    }

    if (newLocalPathList != null) {
      // create photo path list and proccess the images
      final List<QuestionPhotoPath> questionPhotoPathListData =
          _createPathList(studentId, newLocalPathList);
      final questionPhotoPathList = QuestionPhotoPathList(
          questionPhotoPathList: questionPhotoPathListData);
      final processedPhotoList =
          _resizeAndConvertToJpgForMultiplePhoto(newLocalPathList);

      // save the processed image
      for (var i = 0; i < processedPhotoList.length; i++) {
        final image = decodeJpg(processedPhotoList[i]);
        if (image == null) {
          throw const QuestionUseCaseException(
              QuestionUseCaseExceptionDetail.failedImageProcessing);
        }
        QuestionPhoto questionPhoto =
            QuestionPhoto(path: questionPhotoPathList[i], image: image);
        // TODO: まとめてsaveできるならそうしたほうが良い
        _photoRepository.save(questionPhoto);
      }
      // delete the old images
      final oldQuestionPhotoPathList = question.questionPhotoPathList;
      for (var i = 0; i < oldQuestionPhotoPathList.length; i++) {
        _photoRepository.delete(oldQuestionPhotoPathList[i]);
      }
      // change the question's photo to the new one
      question.changeQuestionPhotoPathList(questionPhotoPathList);
    }

    _repository.save(question);
  }
}

List<QuestionPhotoPath> _createPathList(
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

List<Uint8List> _resizeAndConvertToJpgForMultiplePhoto(
    List<String> localPathList) {
  const sizeThresholdBytes = QuestionPhoto.dataSize;

  List<Uint8List> processedPhotoList = [];

  for (String localPath in localPathList) {
    File file = File(localPath);
    if (file.existsSync()) {
      final originalImageBytes = file.readAsBytesSync();
      final image = decodeImage(originalImageBytes);
      if (image == null) {
        throw const QuestionUseCaseException(
            QuestionUseCaseExceptionDetail.failedImageProcessing);
      }

      if (image.length > sizeThresholdBytes) {
        int newWidth =
            (image.width * sizeThresholdBytes / image.length).round();
        int newHeight =
            (image.height * sizeThresholdBytes / image.length).round();

        Image resizedImage =
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
