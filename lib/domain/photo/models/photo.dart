import 'package:image/image.dart';

import 'photo_path.dart';

abstract class Photo {
  final PhotoPath _path;
  final Image _image;

  PhotoPath get path => _path;
  Image get image => _image;

  Photo({required final PhotoPath path, required final Image image})
      : _path = path,
        _image = image {
    validate(image);
  }

  void validate(final Image image);
}
