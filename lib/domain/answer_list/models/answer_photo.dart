import 'package:image/image.dart';
import '../../photo/models/photo.dart';
import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerPhoto extends Photo {
  static const int dataSize = 1024 * 1024;

  AnswerPhoto({required super.path, required super.image});

  @override
  void validate(final Image image) {
    if (image.length != dataSize) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
