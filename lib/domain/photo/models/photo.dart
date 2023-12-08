import '../../../common/exception/photo/photo_creation_exception.dart';
import '../../../common/exception/photo/photo_creation_exception_detail.dart';
import 'photo_file_format.dart';

class Photo {
  final String _pathOrUrl;
  final _localPathRegExp =
      RegExp(r'^[/\\]?[a-zA-Z0-9_\-\.]+\.' + regExpOfPhotoFileFormat);
  final _cloudPathRegExp = RegExp(
      r'^(http|https)://([a-zA-Z0-9\-\.]+\.[a-zA-Z]+)(/[a-zA-Z0-9\-\._?&=]*)?$');

  String get pathOrURl => _pathOrUrl;

  Photo({required final String pathOrUrl}) : _pathOrUrl = pathOrUrl {
    _validate(_pathOrUrl);
  }

  void _validate(final String pathOrUrl) {
    if (pathOrUrl.isEmpty) {
      throw const PhotoCreationException(PhotoCreationExceptionDetail.empty);
    }
    if (!_localPathRegExp.hasMatch(pathOrUrl) &&
        !_cloudPathRegExp.hasMatch(pathOrUrl)) {
      throw const PhotoCreationException(
          PhotoCreationExceptionDetail.invalidPathFormat);
    }
  }
}
