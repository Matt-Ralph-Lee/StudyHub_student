import '../../../common/exception/photo/photo_creation_exception.dart';
import '../../../common/exception/photo/photo_creation_exception_detail.dart';

class PhotoId {
  final String _value;

  String get value => _value;

  PhotoId(this._value) {
    if (_value.isEmpty) {
      throw const PhotoCreationException(PhotoCreationExceptionDetail.empty);
    }
  }
}
