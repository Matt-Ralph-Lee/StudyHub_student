import '../../photo/models/photo_path.dart';
import '../../photo/models/photo_path_list.dart';
import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerPhotoPathList extends PhotoPathList {
  static const maxLength = 4;

  AnswerPhotoPathList(super.photoPathList);

  @override
  void validate(List<PhotoPath> photoPathList) {
    if (photoPathList.length > maxLength) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoLength);
    }
  }
}
