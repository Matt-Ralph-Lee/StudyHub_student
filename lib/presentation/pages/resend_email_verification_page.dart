import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/resend_email_verification_widget.dart';
import '../shared/constants/color_set.dart';

class ResendEmailVerificationPage extends StatelessWidget {
  final String emailAddress;
  const ResendEmailVerificationPage({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.1;
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.1;

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: topPadding),
            ResendEmailVerificationWidget(
              emailAddress: emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
