import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

import '../../../domain/shared/subject.dart';
import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../shared/session/i_session.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/i_question_factory.dart';
import '../../../domain/photo/models/i_profile_photo_repository.dart';

import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/question_photo_path.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/selected_teacher_list.dart';

class QuestionCreateUseCase {
  final ISession _session;
  final IQuestionRepository _repository;
  final IQuestionFactory _factory;
  final IPhotoRepository _photoRepository;

  QuestionCreateUseCase({
    required final ISession session,
    required final IQuestionRepository repository,
    required final IQuestionFactory factory,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _factory = factory,
        _photoRepository = photoRepository;

  Future<void> execute({
    required final String questionTitleData,
    required final String questionTextData,
    required final List<String> localPathList,
    required final Subject questionSubject,
    required final List<String> selectedTeacherListData,
  }) async {
    final StudentId studentId = _session.studentId;
    final QuestionTitle questionTitle = QuestionTitle(questionTitleData);
    final QuestionText questionText = QuestionText(questionTextData);
    final SelectedTeacherList selectedTeacherList = SelectedTeacherList(
        selectedTeacherList: selectedTeacherListData
            .map((selectedTeacher) => TeacherId(selectedTeacher))
            .toList());

    final List<QuestionPhotoPath> questionPhotoPathListData =
        _createPathList(studentId, localPathList);
    final QuestionPhotoPathList questionPhotoPathList =
        QuestionPhotoPathList(questionPhotoPathList: questionPhotoPathListData);

    final List<Uint8List> processedPhotoList =
        _resizeAndConvertToJpgForMultiplePhoto(localPathList);

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

    final Question question = await _factory.createQuestion(
        questionSubject,
        studentId,
        questionTitle,
        questionText,
        questionPhotoPathList,
        selectedTeacherList);

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
