import '../generic_exception.dart';
import 'photo_creation_exception_detail.dart';

class PhotoCreationException extends GenericException {
  const PhotoCreationException(
    PhotoCreationExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
