import '../../../common/exception/photo_exception/photo_creation_exception.dart';
import '../../../common/exception/photo_exception/photo_creation_exception_detail.dart';

class PhotoPath {
  final String _value;
  final _localPathRegExp =
      RegExp(r'^([a-zA-Z0-9\-_.]+)(/[a-zA-Z0-9\-_.]+)*(\.[a-zA-Z0-9\-_]+)?$');
  final _cloudPathRegExp = RegExp(
      r'^(http|https)://([a-zA-Z0-9\-\.]+\.[a-zA-Z]+)(/[a-zA-Z0-9\-\._?&=]*)?$');

  String get value => _value;

  PhotoPath(this._value) {
    _validate(_value);
  }

  void _validate(final String value) {
    if (value.isEmpty) {
      throw const PhotoCreationException(PhotoCreationExceptionDetail.empty);
    }
    if (!_localPathRegExp.hasMatch(value) &&
        !_cloudPathRegExp.hasMatch(value)) {
      throw const PhotoCreationException(
          PhotoCreationExceptionDetail.invalidPathFormat);
    }
  }

  String getName() {
    final basename = _value.split('/').last;
    return basename.split('.').first;
  }

  String getExtension() {
    return _value.split('.').last;
  }
}
