import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';

class TermsOfServiceWidget extends StatelessWidget {
  const TermsOfServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final termsOfUseUrl = Uri.parse(L10n.termsOfUseUrlText);
    final privacyPolicyUrl = Uri.parse(L10n.privacyPolicyUrlText);

    return Column(
      children: [
        const TextForMenuItems(
            menuItemText: L10n.termsOfServiceInformationButtonExplanationText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 15),
        ),
        ElevatedButtonForMenuItems(
            onPressed: () => launchUrl(termsOfUseUrl),
            buttonText: L10n.termsOfServiceButtonText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
            onPressed: () => launchUrl(privacyPolicyUrl),
            buttonText: L10n.privacyPolicyButtonText)
      ],
    );
  }
}
