import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/login_by_google_button_widget.dart';
import '../components/widgets/login_widget.dart';
import '../components/widgets/reset_password_text_button_widget.dart';
import '../components/widgets/sign_up_widget.dart';
import '../controllers/sample_controller/sample_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.1;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingTop = screenHeight * 0.2;
    //コード長いので定数として定義しておく
    Widget orLine = SizedBox(
      width: screenWidth * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "or",
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.annotation,
                color: Colors.grey),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );

    final state = ref.watch(sampleControllerProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorSet.of(context).background,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: paddingTop),
                TabBar(
                  indicatorColor: ColorSet.of(context).primary,
                  dividerColor: Colors.transparent,
                  labelColor: ColorSet.of(context).text,
                  unselectedLabelColor: ColorSet.of(context).unselectedText,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.header3),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.header3),
                  tabs: const [
                    Tab(text: L10n.loginToggleText),
                    Tab(text: L10n.signUpToggleText),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingHorizontal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            const LoginWidget(),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [ResetPasswordTextButtonWidget()],
                            ),
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [orLine]),
                            const SizedBox(height: 50),
                            const LoginByGoogleButtonWidget(),
                          ],
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50),
                          SignUpWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (state.isLoading) const LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}
