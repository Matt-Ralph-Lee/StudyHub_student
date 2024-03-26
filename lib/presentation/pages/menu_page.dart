import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/account_related_menu_widget.dart';
import '../components/widgets/other_function_menu_widget.dart';
import '../components/widgets/terms_of_service_menu_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

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
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          L10n.menuText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.body,
              ),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: PaddingSet.getPaddingSize(context, 30),
              ),
              const OtherFunctionMenuWidget(),
              SizedBox(
                height: PaddingSet.getPaddingSize(context, 20),
              ),
              const TermsOfServiceWidget(),
              SizedBox(
                height: PaddingSet.getPaddingSize(context, 20),
              ),
              const AccountRelatedMenuWidget(),
              SizedBox(
                height: PaddingSet.getPaddingSize(context, 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
