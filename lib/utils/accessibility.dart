import '../presentation/shared/constants/page_path.dart';

bool isPrivate(String path) {
  final privatePath = [
    PageId.page1.path,
    PageId.page2.path,
    PageId.page3.path,
    PageId.favoriteTeachers,
  ];

  return privatePath.contains(path);
}
