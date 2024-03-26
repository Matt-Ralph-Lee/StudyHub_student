import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";
import "../../shared/constants/page_path.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';

class AccountRelatedMenuWidget extends StatelessWidget {
  const AccountRelatedMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToEditProfilePage(BuildContext context) {
      context.push(PageId.editProfile.path);
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
            onPressed: () => navigateToEditProfilePage(context),
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
