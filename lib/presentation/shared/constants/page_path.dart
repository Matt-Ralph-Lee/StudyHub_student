/// 画面ID
enum PageId {
  login,
  loginByGoogle,
  authPage,
  resetPassword,
  profileInput,
  menu,
  searchTeachers,
  favoriteTeachers,
  notifications,
  editProfile,
  page1,
  page2,
  page3,
}

/// 画面パス
extension PagePath on PageId {
  String get path => switch (this) {
        PageId.login => "/login",
        PageId.loginByGoogle => "/loginByGoogle",
        PageId.authPage => "/authPage",
        PageId.resetPassword => "/resetPassword",
        PageId.profileInput => "/profileInput",
        PageId.menu => "/menu",
        PageId.searchTeachers => "/searchTeachers",
        PageId.favoriteTeachers => "/favoriteTeachers",
        PageId.notifications => "/notifications",
        PageId.editProfile => "/editProfile",
        PageId.page1 => "/page1",
        PageId.page2 => "/page2",
        PageId.page3 => "/page3",
      };
}

/// 画面名
extension PageName on PageId {
  String get routeName => switch (this) {
        PageId.login => "login",
        PageId.loginByGoogle => "/loginByGoogle",
        PageId.authPage => "authPage",
        PageId.resetPassword => "resetPassword",
        PageId.profileInput => "/profileInput",
        PageId.menu => "/menu",
        PageId.searchTeachers => "/searchTeachers",
        PageId.favoriteTeachers => "/favoriteTeachers",
        PageId.notifications => "/notifications",
        PageId.editProfile => "/editProfile",
        PageId.page1 => "page1",
        PageId.page2 => "page2",
        PageId.page3 => "page3",
      };
}
