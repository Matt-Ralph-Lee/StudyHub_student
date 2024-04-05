import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/student_auth/exception/student_auth_domain_exception.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart';
import '../../controllers/resend_email_verification_controller/resend_email_verification_controller.dart';
import '../../controllers/student_auth_controller/student_auth_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../parts/completion_snack_bar.dart';
import '../parts/elevated_button_for_auth.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class ResendEmailVerificationWidget extends HookConsumerWidget {
  final String emailAddress;
  const ResendEmailVerificationWidget({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void resendEmailVerification() async {
      ref
          .read(resendEmailVerificationControllerProvider.notifier)
          .resendEmailVerification(emailAddress)
          .then((_) {
        final currentState =
            ref.read(resendEmailVerificationControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          if (error is StudentAuthDomainException) {
            final errorText = L10n.getStudentAuthExceptionMessage(
                error.detail as StudentAuthDomainExceptionDetail);
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
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.resendEmailVerificationText),
          );
        }
      });
    }

    void logOut() async {
      ref.read(studentAuthControllerProvider.notifier).singOut().then((_) {
        final currentState = ref.read(studentAuthControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          if (error is StudentAuthDomainException) {
            final errorText = L10n.getStudentAuthExceptionMessage(
                error.detail as StudentAuthDomainExceptionDetail);
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
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.logoutSnackBarText),
          );
          navigateToAuthPage(context);
        }
      });
    }

    void deleteAccount() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmAccountDeleteModalWidget();
          });
      if (result) {
        ref
            .read(deleteAccountControllerProvider.notifier)
            .deleteAccount()
            .then((_) {
          final addQuestionState = ref.read(deleteAccountControllerProvider);
          if (addQuestionState.hasError) {
            final error = addQuestionState.error;
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
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              completionSnackBar(context, L10n.deleteAccountSnackBarText),
            );
            navigateToAuthPage(context);
          }
        });
      }
    }

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
      body: Column(
        children: [
          Text(
            L10n.emailVerificationTitleText,
            style: TextStyle(
              color: ColorSet.of(context).text,
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header1),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            L10n.emailVerificationSubtitleText,
            style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
              color: ColorSet.of(context).text,
            ),
          ),
          const SizedBox(height: 80),
          ElevatedButtonForAuth(
            onPressed: () => resendEmailVerification(),
            buttonText: L10n.emailVerificationButtonText,
          )
        ],
      ),
    );
  }
}
