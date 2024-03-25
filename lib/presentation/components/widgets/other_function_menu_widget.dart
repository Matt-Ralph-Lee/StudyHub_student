import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../shared/constants/l10n.dart";
import "../../shared/constants/page_path.dart";
import "../parts/elevated_button_for_menu_items.dart";
import '../parts/text_for_menu_items.dart';

class OtherFunctionMenuWidget extends StatelessWidget {
  const OtherFunctionMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void push(BuildContext context) {
      context.push(PageId.searchTeachers.path);
    }

    return Column(
      children: [
        const TextForMenuItems(
            menuItemText: L10n.otherFunctionsButtonExplanationText),
        const SizedBox(height: 15),
        ElevatedButtonForMenuItems(
            onPressed: () => push(context),
            buttonText: L10n.searchTeachersButtonText)
      ],
    );
  }
}
