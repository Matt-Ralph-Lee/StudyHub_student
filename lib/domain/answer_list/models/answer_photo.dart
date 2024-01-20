import 'package:image/image.dart';
import '../../photo/models/photo.dart';
import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerPhoto extends Photo {
  static const height = 480;
  static const width = 640;

  AnswerPhoto({required super.path, required super.image});

  @override
  void validate(final Image image) {
    if (image.height != height) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoSize);
    }
    if (image.width > width) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
