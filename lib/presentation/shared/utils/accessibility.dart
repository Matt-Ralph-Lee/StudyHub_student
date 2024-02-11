import '../constants/page_path.dart';

bool requiresLoggedOut(String path) {
  final requiresLoggedOutPath = [
    PageId.login.path,
    PageId.authPage.path,
    PageId.resetPassword.path,
  ];

  return requiresLoggedOutPath.contains(path);
}

bool isPrivate(String path) {
  final privatePath = [
    PageId.page1.path,
    PageId.page2.path,
    PageId.page3.path,
  ];

  return privatePath.contains(path);
}
