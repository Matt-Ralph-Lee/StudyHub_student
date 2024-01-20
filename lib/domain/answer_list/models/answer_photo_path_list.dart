import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

import 'answer_photo_path.dart';

class AnswerPhotoPathList {
  final List<AnswerPhotoPath> _questionPhotoPathList;
  static const maxLength = 4;

  List<AnswerPhotoPath> get questionPhotoPathList => _questionPhotoPathList;

  AnswerPhotoPathList({
    required final List<AnswerPhotoPath> questionPhotoPathList,
  }) : _questionPhotoPathList = questionPhotoPathList {
    if (_questionPhotoPathList.length > maxLength) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoLength);
    }
  }
}
