import '../../photo/models/photo_path.dart';
import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';
import 'answer_photo_format.dart';

class AnswerPhotoPath extends PhotoPath {
  final _pathRegExp =
      RegExp(r'^[/\w\-_.]+\.(' + AnswerPhotoFormat.regExpString + r')$');

  AnswerPhotoPath(super.value);

  @override
  void validate(String value) {
    if (!_pathRegExp.hasMatch(value)) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoPath);
    }
  }
}
