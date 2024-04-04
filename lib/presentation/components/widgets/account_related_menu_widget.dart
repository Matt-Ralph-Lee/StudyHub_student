import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../../domain/student_auth/exception/student_auth_domain_exception.dart";
import "../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart";
import "../../controllers/student_auth_controller/student_auth_controller.dart";
import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";
import "../../shared/constants/page_path.dart";
import "../parts/completion_snack_bar.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';
import "show_error_modal_widget.dart";
import "specific_exception_modal_widget.dart";

class AccountRelatedMenuWidget extends ConsumerWidget {
  const AccountRelatedMenuWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void navigateToEditProfilePage(BuildContext context) {
      context.push(PageId.editProfile.path);
    }

    void navigateToAuthPage(BuildContext context) {
      context.push(PageId.authPage.path);
    }

    return Column(
      children: [
        const TextForMenuItems(
            menuItemText: L10n.accountRelatedButtonExplanationText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 15),
        ),
        ElevatedButtonForMenuItems(
            onPressed: () => navigateToEditProfilePage(context),
            buttonText: L10n.editAccountInformationButtonText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
            onPressed: () {
              ref
                  .read(studentAuthControllerProvider.notifier)
                  .singOut()
                  .then((_) {
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
            },
            buttonText: L10n.logoutButtonText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
          onPressed: () => navigateToEditProfilePage(context),
          buttonText: L10n.deleteAccountButtonText,
        )
      ],
    );
  }
}
