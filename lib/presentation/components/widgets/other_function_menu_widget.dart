import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:url_launcher/url_launcher.dart";

import "../../shared/constants/l10n.dart";
import "../../shared/constants/padding_set.dart";
import "../../shared/constants/page_path.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';

class OtherFunctionMenuWidget extends StatelessWidget {
  const OtherFunctionMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inquiryUrl = Uri.parse(L10n.inquiryUrlText);

    void push(BuildContext context) {
      context.push(PageId.searchTeachers.path);
    }

    void navigateToBlockingPage(BuildContext context) {
      context.push(PageId.blockingTeacherPage.path);
    }

    return Column(
      children: [
        const TextForMenuItems(
            menuItemText: L10n.otherFunctionsButtonExplanationText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 15),
        ),
        ElevatedButtonForMenuItems(
            onPressed: () => push(context),
            buttonText: L10n.searchTeachersButtonText),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
          onPressed: () => navigateToBlockingPage(context),
          buttonText: L10n.checkBlockingTeachersButtonText,
        ),
        SizedBox(
          height: PaddingSet.getPaddingSize(context, 30),
        ),
        ElevatedButtonForMenuItems(
          onPressed: () => launchUrl(inquiryUrl),
          buttonText: L10n.inquiryButtonText,
        )
      ],
    );
  }
}
