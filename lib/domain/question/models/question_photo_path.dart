import '../../photo/models/photo_path.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';
import 'question_photo_format.dart';

class QuestionPhotoPath extends PhotoPath {
  final _pathRegExp = RegExp(r'^photos/question_photo/[a-zA-Z0-9_-]+\.(' +
      questionPhotoFormatsRegExpString +
      r')$');

  QuestionPhotoPath(super.value);

  @override
  void validate(String value) {
    if (!_pathRegExp.hasMatch(value)) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoPath);
    }
  }
}
