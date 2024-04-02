import 'dart:typed_data';

import 'photo.dart';
import 'photo_path.dart';
import 'photo_path_list.dart';

abstract class IPhotoRepository {
  Uint8List get(final PhotoPath photoPath);
  void save(final List<Photo> photoList);
  void delete(final PhotoPath photoPath);
  void deleteList(final PhotoPathList photoPathList);
}
