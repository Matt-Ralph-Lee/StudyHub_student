import 'photo_id.dart';
import 'photo_path.dart';

class Photo {
  final PhotoId _photoId;
  final PhotoPath _photoPath;

  PhotoId get photoId => _photoId;

  Photo({required final PhotoId photoId, required final PhotoPath path})
      : _photoId = photoId,
        _photoPath = path;

  factory Photo.fromPhotoPath(final PhotoPath photoPath) {
    final name = photoPath.getName();
    final now = DateTime.now();
    final referenceName =
        '${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}-$name.png';
    final photoId = PhotoId(referenceName);
    return Photo(photoId: photoId, path: photoPath);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Photo) {
      return runtimeType == other.runtimeType && _photoId == other.photoId;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _photoId.hashCode;
}
