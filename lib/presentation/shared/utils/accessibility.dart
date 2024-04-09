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
    PageId.home.path,
    PageId.addQuestion.path,
    PageId.myPage.path,
    PageId.profileInput.path,
    PageId.menu.path,
    PageId.searchTeachers.path,
    PageId.favoriteTeachers.path,
    PageId.notifications.path,
    PageId.editProfile.path,
    PageId.evaluationPage.path,
    PageId.selectTeachers.path,
    PageId.teacherProfile.path,
    PageId.questionAndAnswerPage.path,
    PageId.searchQuestions.path,
    PageId.reportQuestionPage.path,
    PageId.checkQuestionImagePage.path,
    PageId.checkAnswerImagePage.path,
    PageId.notificationDetailPage.path,
  ];

  return privatePath.contains(path);
}
