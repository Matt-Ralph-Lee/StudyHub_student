import "package:riverpod_annotation/riverpod_annotation.dart";

part "tmp.g.dart";

// login, logout methodは本来は存在せず、authのproviderはBasic Providerである
// FirebaseやInMemoryのauthをBase Providerで実装するのがこのファイルである。
// 今はNotifier, NotifierProviderで実装している。

@riverpod
class Tmp extends _$Tmp {
  @override
  bool build() {
    // initial data
    // if you want it to be logged in from the first point, set the return to true
    return false;
  }

  void login() {
    state = true;
  }

  void logout() {
    state = false;
  }
}
