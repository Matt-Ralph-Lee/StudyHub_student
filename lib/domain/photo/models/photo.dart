import 'dart:typed_data';

import 'photo_path.dart';

abstract class Photo {
  final PhotoPath _path;
  final Uint8List _data;
  final int _height;
  final int _width;

  Photo({
    required final PhotoPath path,
    required final Uint8List data,
    required final int height,
    required final int width,
  })  : _path = path,
        _data = data,
        _height = height,
        _width = width {
    validate(height: height, width: width);
  }

  PhotoPath get path => _path;
  Uint8List get data => _data;
  int get height => _height;
  int get width => _width;

  void validate({
    required final int height,
    required final int width,
  });
}
