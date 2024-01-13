import 'package:image/image.dart';

import '../../student/models/profile_photo/profile_photo_path.dart';

abstract class Photo {
  final ProfilePhotoPath _path;
  final Image _image;

  ProfilePhotoPath get path => _path;
  Image get image => _image;

  Photo({required final ProfilePhotoPath path, required final Image image})
      : _path = path,
        _image = image {
    validate(image);
  }

  void validate(final Image image);
}
