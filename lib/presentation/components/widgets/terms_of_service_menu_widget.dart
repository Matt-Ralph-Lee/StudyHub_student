import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../shared/constants/l10n.dart";
import "../../shared/constants/page_path.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';

class TermsOfServiceWidget extends StatelessWidget {
  const TermsOfServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //遷移先ページはまだ作ってないっす
    void push(BuildContext context) {
      context.push(PageId.searchTeachers.path);
    }

    return Column(
      children: [
        const TextForMenuItems(
            menuItemText: L10n.termsOfServiceInformationButtonExplanationText),
        const SizedBox(height: 15),
        ElevatedButtonForMenuItems(
            onPressed: () => push(context),
            buttonText: L10n.termsOfServiceButtonText),
        const SizedBox(height: 30),
        ElevatedButtonForMenuItems(
            onPressed: () => push(context),
            buttonText: L10n.privacyPolicyButtonText)
      ],
    );
  }
}
