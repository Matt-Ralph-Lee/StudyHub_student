import 'package:image/image.dart';
import '../../photo/models/photo.dart';
import '../../photo/models/photo_path.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionPhoto extends Photo {
  static const int dataSize = 1024 * 1024;

  QuestionPhoto._(
      {required super.path,
      required super.data,
      required super.height,
      required super.width});

  factory QuestionPhoto.fromImage({
    required final PhotoPath path,
    required final Image image,
  }) {
    final height = image.height;
    final width = image.width;
    final data = encodeJpg(image);

    return QuestionPhoto._(
        path: path, data: data, height: height, width: width);
  }

  @override
  void validate({required int height, required int width}) {
    if (height * width > dataSize) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoSize);
    }
  }
}
