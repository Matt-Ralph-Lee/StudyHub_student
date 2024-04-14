import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/shared/subject.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/text_for_error.dart';
import 'question_pictures_for_confirm_widget.dart';
import 'teacher_profile_for_confirm_skeleton_widget.dart';
import 'teacher_profile_for_confirm_widget.dart';

class ConfirmQuestionModalWidget extends ConsumerWidget {
  final String questionTitle;
  final String questionContent;
  final Subject subject;
  final List<String> imagesPath;
  final List<TeacherId> teacherId;

  const ConfirmQuestionModalWidget({
    super.key,
    required this.questionTitle,
    required this.questionContent,
    required this.subject,
    required this.imagesPath,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Dialog(
      backgroundColor: ColorSet.of(context).surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    L10n.confirmQuestionModalTitleText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.semibold,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingSet.getPaddingSize(
                    context,
                    PaddingSet.horizontalPadding,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      L10n.subjectTextForConfirm,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.annotation,
                          ),
                          color: ColorSet.of(context).greyText),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subject.japanese,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.body,
                          ),
                          color: ColorSet.of(context).text),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      L10n.questionTitleTextForConfirm,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.annotation,
                          ),
                          color: ColorSet.of(context).greyText),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      questionTitle,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.body,
                          ),
                          color: ColorSet.of(context).text),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      L10n.questionContentTextForConfirm,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.annotation,
                          ),
                          color: ColorSet.of(context).greyText),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      questionContent,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.body,
                          ),
                          color: ColorSet.of(context).text),
                    ),
                  ],
                ),
              ),
              if (imagesPath.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        L10n.photosTextForConfirm,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                              context,
                              FontSizeSet.annotation,
                            ),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imagesPath.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: QuestionPictureForConfirmWidget(
                                    photoPath: imagesPath[index],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (teacherId.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        L10n.selectedTeachersTextForConfirm,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 80, //ipadレスポンシブ
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: teacherId.length,
                          itemBuilder: (context, index) {
                            final getTeacherProfileState = ref.watch(
                                getTeacherProfileControllerProvider(
                                    teacherId[index]));
                            return getTeacherProfileState.when(
                              data: (teacherProfileDto) => teacherProfileDto !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TeacherProfileWForConfirmWidget(
                                        teacherProfileDto: teacherProfileDto,
                                      ),
                                    )
                                  : Text(
                                      L10n.noTeacherProfileFoundText,
                                      style: TextStyle(
                                          fontWeight: FontWeightSet.normal,
                                          fontSize: FontSizeSet.getFontSize(
                                              context, FontSizeSet.body),
                                          color: ColorSet.of(context).text),
                                    ),
                              loading: () => const Padding(
                                padding: EdgeInsets.all(10.0),
                                child:
                                    TeacherProfileWForConfirmSkeletonWidget(),
                              ),
                              error: (error, stack) {
                                return const Center(
                                    child: Column(
                                  children: [
                                    TextForError(),
                                  ],
                                ));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.body,
                          ),
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
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        ),
                        color: ColorSet.of(context).primary,
                      ),
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
