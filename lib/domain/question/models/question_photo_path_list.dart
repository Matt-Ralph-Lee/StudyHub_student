import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

import 'question_photo_path.dart';

class QuestionPhotoPathList {
  final List<QuestionPhotoPath> _questionPhotoPathList;
  static const maxLength = 4;

  int get length => _questionPhotoPathList.length;
  List<QuestionPhotoPath> get questionPhotoPathList => _questionPhotoPathList;

  QuestionPhotoPathList({
    required final List<QuestionPhotoPath> questionPhotoPathList,
  }) : _questionPhotoPathList = questionPhotoPathList {
    if (_questionPhotoPathList.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoLength);
    }
  }

  QuestionPhotoPath operator [](int index) {
    if (index < 0 || index >= _questionPhotoPathList.length) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidIndex);
    }
    return _questionPhotoPathList[index];
  }
}
