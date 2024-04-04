import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/domain/report/models/report_reason.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class ConfirmReportModalWidget extends StatelessWidget {
  final ReportReason reportReason;
  final String reportContentText;
  const ConfirmReportModalWidget({
    super.key,
    required this.reportReason,
    required this.reportContentText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorSet.of(context).surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            PaddingSet.getPaddingSize(
              context,
              PaddingSet.horizontalPadding,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    L10n.confirmModalTitleText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                reportReason.japanese,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                reportContentText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    child: Text(
                      L10n.cancelText,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.body,
                          color: ColorSet.of(context).text),
                    ),
                    onPressed: () {
                      context.pop(false);
                    },
                  ),
                  TextButton(
                    child: Text(
                      L10n.modalOkText,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.body,
                          color: ColorSet.of(context).text),
                    ),
                    onPressed: () {
                      context.pop(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
