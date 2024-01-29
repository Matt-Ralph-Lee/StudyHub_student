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
import 'utils/image_processing.dart';

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
    required final List<TeacherId> selectedTeacherListData,
  }) async {
    final StudentId studentId = _session.studentId;
    final QuestionTitle questionTitle = QuestionTitle(questionTitleData);
    final QuestionText questionText = QuestionText(questionTextData);
    final SelectedTeacherList selectedTeacherList =
        SelectedTeacherList(selectedTeacherList: selectedTeacherListData);

    final List<QuestionPhotoPath> questionPhotoPathListData =
        createPathList(studentId, localPathList);
    final QuestionPhotoPathList questionPhotoPathList =
        QuestionPhotoPathList(questionPhotoPathListData);

    final List<Uint8List> processedPhotoList =
        resizeAndConvertToJpgForMultiplePhoto(localPathList);
    // final List<Image> processedPhotoList =
    //     resizeAndConvertToJpgForMultiplePhoto(localPathList);

    List<QuestionPhoto> questionPhotoList = [];

    // final List<QuestionPhoto> questionPhotoList = [
    //   for (int i = 0; i < processedPhotoList.length; i++)
    //     QuestionPhoto(
    //         path: questionPhotoPathList[i], image: processedPhotoList[i])
    // ];

    for (var i = 0; i < processedPhotoList.length; i++) {
      final image = decodeJpg(processedPhotoList[i]);
      if (image == null) {
        throw const QuestionUseCaseException(
            QuestionUseCaseExceptionDetail.failedImageProcessing);
      }
      QuestionPhoto questionPhoto =
          QuestionPhoto(path: questionPhotoPathList[i], image: image);
      questionPhotoList.add(questionPhoto);
    }

    _photoRepository.save(questionPhotoList);

    final Question question = await _factory.createQuestion(
        questionSubject: questionSubject,
        studentId: studentId,
        questionTitle: questionTitle,
        questionText: questionText,
        questionPhotoPathList: questionPhotoPathList,
        selectedTeacherList: selectedTeacherList);

    _repository.save(question);
  }
}
