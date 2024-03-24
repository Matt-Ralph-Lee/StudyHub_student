import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_evaluation_found.dart';
import '../components/widgets/evaluations_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/teacher_profile_widget.dart';
import '../controllers/get_teacher_evaluation_controller/get_teacher_evaluation_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class TeacherProfilePage extends ConsumerWidget {
  final GetTeacherProfileDto getTeacherProfileDto;
  const TeacherProfilePage({super.key, required this.getTeacherProfileDto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTeacherEvaluationState = ref
        .watch(getTeacherEvaluationControllerProvider("teacherIDはどうやって取得する？"));　//前のカードからid受け取って、このページでプロフをgetする。
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
            "教師のプロフィール",
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
                color: ColorSet.of(context).text),
          ),
        ),
        backgroundColor: ColorSet.of(context).background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TeacherProfileWidget(
                  teacherProfileDto: getTeacherProfileDto,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: getTeacherEvaluationState.when(
                  data: (teachers) => teachers.isNotEmpty
                      ? EvaluationsWidget(teacherEvaluationsDto: teachers)
                      : const Center(
                          child: TextForNoEvaluationFound(),
                        ),
                  loading: () => const LoadingOverlay(),
                  //エラーときはテキストだけじゃなくてステップアップのログとかと一緒に表示するのもありかも？
                  error: (error, stack) {
                    print("エラーはこれです${error}");
                    print(stack);
                    return const Center(
                        child: Column(
                      children: [
                        TextForError(),
                      ],
                    ));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
