import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../../application/student/exception/student_use_case_exception.dart";
import "../../../application/student/exception/student_use_case_exception_detail.dart";
import "../../../domain/student_auth/exception/student_auth_domain_exception.dart";
import "../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart";
import "../../controllers/delete_account_controller/delete_account_controller.dart";
import "../../controllers/student_auth_controller/student_auth_controller.dart";
import "../../shared/constants/handle_error.dart";
import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";
import "../../shared/constants/page_path.dart";
import "../parts/completion_snack_bar.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';
import 'confirm_account_delete_modal.dart';
import "error_modal_widget.dart";

class AccountRelatedMenuWidget extends ConsumerWidget {
  const AccountRelatedMenuWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    void navigateToEditProfilePage(BuildContext context) {
      context.push(PageId.editProfile.path);
    }

    void navigateToAuthPage(BuildContext context) {
      context.go(PageId.authPage.path);
    }

    void logOut() async {
      await ref
          .read(studentAuthControllerProvider.notifier)
          .signOut()
          .then((_) {
        final currentState = ref.read(studentAuthControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          final errorMessage = handleError(context, error);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorModalWidget(
                errorMessage: errorMessage,
              );
            },
          );
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
            final errorMessage = handleError(context, error);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorModalWidget(
                  errorMessage: errorMessage,
                );
              },
            );
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
            onPressed: () => logOut(), buttonText: L10n.logoutButtonText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
          onPressed: () => deleteAccount(),
          buttonText: L10n.deleteAccountButtonText,
        )
      ],
    );
  }
}
