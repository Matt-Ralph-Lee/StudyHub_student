/// 画面ID
enum PageId {
  login,
  loginByGoogle,
  authPage,
  resetPassword,
  profileInput,
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
        PageId.page1 => "page1",
        PageId.page2 => "page2",
        PageId.page3 => "page3",
      };
}