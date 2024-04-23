import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/student/exception/student_use_case_exception.dart';
import '../../application/student/exception/student_use_case_exception_detail.dart';
import '../components/widgets/resend_email_verification_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../controllers/delete_account_controller/delete_account_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class ResendEmailVerificationPage extends ConsumerWidget {
  final String emailAddress;
  const ResendEmailVerificationPage({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context, ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.1;

    void backToSignUpPage() async {
      ref
          .read(deleteAccountControllerProvider.notifier)
          .deleteAccount()
          .then((_) {
        final deleteAccountState = ref.read(deleteAccountControllerProvider);
        if (deleteAccountState.hasError) {
          final error = deleteAccountState.error;
          if (error is StudentUseCaseException) {
            final errorText = L10n.getStudentUseCaseExceptionMessage(
                error.detail as StudentUseCaseExceptionDetail);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SpecificExceptionModalWidget(
                    errorMessage: errorText,
                  );
                });
          } else {
            showErrorModalWidget(context);
          }
        } else {
          context.go(PageId.authPage.path);
        }
      });
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      appBar: AppBar(
        backgroundColor: ColorSet.of(context).background,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            size: FontSizeSet.getFontSize(context, 30),
            color: ColorSet.of(context).icon,
          ),
          onPressed: () => backToSignUpPage(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PaddingSet.getPaddingSize(
            context,
            PaddingSet.horizontalPadding,
          ),
        ),
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
