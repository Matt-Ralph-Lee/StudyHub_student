import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/report/application_service/question_report_submit_command.dart';
import '../../application/report/application_service/teacher_report_submit_command.dart';
import '../../domain/question/models/question_id.dart';
import '../../domain/report/models/report_reason.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/parts/drop_down_button_for_report_reason.dart';
import '../components/parts/text_form_field_for_report_input.dart';
import '../components/widgets/confirm_report_modal_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../controllers/report_question_controller/report_question_controller.dart';
import '../controllers/report_teacher_controller/report_teacher_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/utils/handle_error.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class ReportPage extends HookConsumerWidget {
  //まとめてるから気持ち悪い？かも
  final QuestionId? questionId;
  final TeacherId? teacherId;
  const ReportPage(
      {super.key, required this.questionId, required this.teacherId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportReason = useState<ReportReason?>(null);
    final reportContentController = useTextEditingController();
    final isReportContentFilled =
        useState<bool>(reportContentController.text.isNotEmpty);

    void checkReportContentFilled(String text) {
      isReportContentFilled.value = text.isNotEmpty;
    }

    final getReportQuestionControllerState =
        ref.watch(reportQuestionControllerProvider);
    final getReportTeacherControllerState =
        ref.watch(reportTeacherControllerProvider);

    void reportQuestion() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmReportModalWidget(
              reportReason: reportReason.value!,
              reportContentText: reportContentController.text,
            );
          });
      if (result) {
        await ref
            .read(reportQuestionControllerProvider.notifier)
            .reportQuestion(QuestionReportSubmitCommand(
                questionId: questionId!, //これ呼び出す側でnullチェック済みなので
                reportReason: reportReason.value!,
                reportTextData: reportContentController.text));

        if (!context.mounted) return;

        final currentState = ref.read(reportQuestionControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          final errorMessage = handleError(error);
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
            completionSnackBar(context, L10n.reportSnackBarText),
          );
          context.pop();
        }
      }
    }

    void reportTeacher() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmReportModalWidget(
              reportReason: reportReason.value!,
              reportContentText: reportContentController.text,
            );
          });
      if (result) {
        await ref
            .read(reportTeacherControllerProvider.notifier)
            .reportTeacher(TeacherReportSubmitCommand(
                teacherId: teacherId!, //これ呼び出す側でnullチェック済みなので
                reportReason: reportReason.value!,
                reportTextData: reportContentController.text));

        if (!context.mounted) return;

        final currentState = ref.read(reportTeacherControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          final errorMessage = handleError(error);
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
            completionSnackBar(context, L10n.reportSnackBarText),
          );
          context.pop();
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
              left: PaddingSet.getPaddingSize(
                context,
                PaddingSet.horizontalPadding,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    L10n.cancelText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 250,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: PaddingSet.getPaddingSize(
                  context,
                  PaddingSet.horizontalPadding,
                ),
              ),
              child: TextButton(
                onPressed:
                    (reportReason.value != null && isReportContentFilled.value)
                        ? (questionId != null
                            ? reportQuestion
                            : reportTeacher) //まとめてるから気持ち悪い？かも
                        : null,
                style: TextButton.styleFrom(
                    foregroundColor: ColorSet.of(context).primary,
                    disabledForegroundColor:
                        ColorSet.of(context).unselectedText),
                child: Text(
                  L10n.reportText,
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                      context,
                      FontSizeSet.body,
                    ),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: ColorSet.of(context).background,
        ),
        backgroundColor: ColorSet.of(context).background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: PaddingSet.getPaddingSize(
                context,
                50,
              ),
              horizontal: PaddingSet.getPaddingSize(
                context,
                PaddingSet.horizontalPadding,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropDownButtonForReportReason(
                  groupValue: reportReason.value,
                  onChanged: (ReportReason? value) {
                    reportReason.value = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormFieldForReportInput(
                  controller: reportContentController,
                  onChanged: checkReportContentFilled,
                ),
                if (getReportQuestionControllerState.isLoading ||
                    getReportTeacherControllerState.isLoading)
                  const LoadingOverlay(),
              ],
            ),
          ),
        ));
  }
}
