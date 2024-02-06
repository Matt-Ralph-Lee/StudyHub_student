import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/presentation/components/parts/sample_button.dart';
import 'package:studyhub/presentation/controllers/sample_controller/sample_controller.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 以下のように用意されてあるcontrollerProviderをwatchしてbackendの処理の「状態」を確認する
    // 「状態」によって表示物や関数を変える
    final state = ref.watch(sampleControllerProvider);
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Center(
        child: SampleButton(
          fc: state.isLoading
              ? null
              : ref.read(sampleControllerProvider.notifier).login,
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text("login"),
        ),
      ),
    );
  }
}
