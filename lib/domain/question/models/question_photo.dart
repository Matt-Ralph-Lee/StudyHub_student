import 'package:image/image.dart';
import '../../photo/models/photo.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionPhoto extends Photo {
  static const int dataSize = 1024 * 1024;

  QuestionPhoto({required super.path, required super.image});

  @override
  void validate(final Image image) {
    if (image.length > dataSize) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
