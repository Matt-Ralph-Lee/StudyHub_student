import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/presentation/components/parts/sample_button.dart';
import 'package:studyhub/presentation/controllers/sample_controller/sample_controller.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class Page3 extends ConsumerWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sampleControllerProvider);
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Center(
        child: SampleButton(
          fc: state.isLoading
              ? null
              : ref.read(sampleControllerProvider.notifier).logout,
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text("logout"),
        ),
      ),
    );
  }
}
