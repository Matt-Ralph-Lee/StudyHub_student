import '../../photo/models/photo_path.dart';
import '../../photo/models/photo_path_list.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionPhotoPathList extends PhotoPathList {
  static const maxLength = 4;

  QuestionPhotoPathList(super.photoPathList);

  // QuestionPhotoPath operator [](int index) {
  //   if (index < 0 || index >= _questionPhotoPathList.length) {
  //     throw const QuestionDomainException(
  //         QuestionDomainExceptionDetail.invalidIndex);
  //   }
  //   return _questionPhotoPathList[index];
  // }

  @override
  void validate(List<PhotoPath> photoPathList) {
    if (photoPathList.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoLength);
    }
  }
}
