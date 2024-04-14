import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/login_widget.dart';
import '../components/widgets/reset_password_text_button_widget.dart';
import '../components/widgets/sign_up_widget.dart';
import '../controllers/student_auth_controller/student_auth_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingTop = screenHeight * 0.2;
    final state = ref.watch(studentAuthControllerProvider);

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
                  labelStyle: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.header3)),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.header3)),
                  tabs: const [
                    Tab(text: L10n.loginToggleText),
                    Tab(text: L10n.signUpToggleText),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              LoginWidget(),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [ResetPasswordTextButtonWidget()],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: const SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 50),
                              SignUpWidget(),
                            ],
                          ),
                        ),
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
