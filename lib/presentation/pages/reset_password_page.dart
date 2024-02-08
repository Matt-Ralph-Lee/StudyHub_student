import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/reset_password_widget.dart';
import '../shared/constants/color_set.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    final topPadding = screenWidth * 0.1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.chevron_left_outlined,
              size: 30,
              color: ColorSet.of(context).text,
            ),
            onPressed: () => context.pop(), // GoRouterを使用して前のページに戻る
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [SizedBox(height: topPadding), ResetPassswordWidget()],
        ),
      ),
    );
  }
}
