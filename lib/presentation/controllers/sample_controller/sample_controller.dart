import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/presentation/auth/tmp.dart";

part 'sample_controller.g.dart';

@riverpod
class SampleController extends _$SampleController {
  @override
  Future<void> build() async {}

  void login() async {
    // 実際はapplication_serviceで用意されてるUseCaseの関数をexecuteする
    final tmp = ref.read(tmpProvider.notifier);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // backend process
      // the loading is caused by this next line of code. comment out if you don't want it.
      await Future.delayed(const Duration(seconds: 1));
      tmp.login();
    });
  }

  void logout() async {
    // 実際はapplication_serviceで用意されてるUseCaseの関数をexecuteする
    final tmp = ref.read(tmpProvider.notifier);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // backend process
      // the loading is caused by this next line of code. comment out if you don't want it.
      await Future.delayed(const Duration(seconds: 1));
      tmp.logout();
    });
  }

  void resetPassword() async {}
}
