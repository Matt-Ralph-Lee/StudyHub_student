import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/components/widgets/other_function_menu_widget.dart';
import 'package:studyhub/presentation/components/widgets/terms_of_service_menu_widget.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

import '../components/widgets/account_related_menu_widget.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
          ),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          'メニュー',
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OtherFunctionMenuWidget(),
            TermsOfServiceWidget(),
            AccountRelatedMenuWidget(),
          ],
        ),
      ),
    );
  }
}
