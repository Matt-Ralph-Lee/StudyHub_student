import 'photo_path.dart';

abstract class PhotoPathList extends Iterable<PhotoPath> {
  final List<PhotoPath> _photoPathList;

  List<PhotoPath> get photoPathList => _photoPathList;

  PhotoPathList(this._photoPathList) {
    validate(_photoPathList);
  }

  void validate(final List<PhotoPath> photoPathList);

  @override
  Iterator<PhotoPath> get iterator => _photoPathList.iterator;
}
