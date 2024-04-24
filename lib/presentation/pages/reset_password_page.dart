import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/reset_password_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/padding_set.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.1;

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorSet.of(context).background,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              size: 30,
              color: ColorSet.of(context).icon,
            ),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingSet.getPaddingSize(
            context,
            PaddingSet.horizontalPadding,
          )),
          child: Column(
            children: [
              SizedBox(height: topPadding),
              const ResetPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
