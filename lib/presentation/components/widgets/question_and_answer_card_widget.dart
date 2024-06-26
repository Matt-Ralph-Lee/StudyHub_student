import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/shared/application_service/question_card_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class QuestionAndAnswerCardWidget extends ConsumerWidget {
  final QuestionCardDto questionCardDto;

  const QuestionAndAnswerCardWidget({
    super.key,
    required this.questionCardDto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void navigateToQuestionAndAnswerPage(BuildContext context) {
      context.push(PageId.questionAndAnswerPage.path, extra: [
        questionCardDto.questionId,
        questionCardDto.isMine,
      ]);
    }

    final studentImage = ref
        .watch(
            getPhotoControllerProvider(questionCardDto.studentProfilePhotoPath))
        .maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_light.png")
                : const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage(
              "assets/photos/profile_photo/sample_user_icon.jpg"),
        );

    final teacherImage = questionCardDto.teacherProfilePhotoPath != null
        ? ref
            .watch(getPhotoControllerProvider(
                questionCardDto.teacherProfilePhotoPath!))
            .maybeWhen(
              data: (d) => d,
              loading: () {
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? const AssetImage(
                        "assets/photos/profile_photo/loading_user_icon_light.png")
                    : const AssetImage(
                        "assets/photos/profile_photo/loading_user_icon_dark.png");
              },
              orElse: () => const AssetImage(
                  "assets/photos/profile_photo/sample_user_icon.jpg"),
            )
        : null;

    return GestureDetector(
      onTap: () => navigateToQuestionAndAnswerPage(context),
      child: Container(
        decoration: BoxDecoration(
          color: ColorSet.of(context).surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: ColorSet.of(context).cardShadow,
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 0)),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(
            screenWidth < 600 ? 20 : 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: screenWidth < 600 ? 15 : 22,
                    backgroundImage: studentImage,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              L10n.questionIconText,
                              style: TextStyle(
                                  fontWeight: FontWeightSet.normal,
                                  fontSize: FontSizeSet.getFontSize(
                                      context, FontSizeSet.body),
                                  color: ColorSet.of(context).questionIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                questionCardDto.questionTitle,
                                style: TextStyle(
                                    fontWeight: FontWeightSet.semibold,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.body),
                                    color: ColorSet.of(context).text),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(questionCardDto.questionText,
                                  style: TextStyle(
                                      fontWeight: FontWeightSet.normal,
                                      fontSize: FontSizeSet.getFontSize(
                                          context, FontSizeSet.body),
                                      color: ColorSet.of(context)
                                          .greyText), //奥行き？が生まれて覗きたくなるタップしたくなる気がしたのでgreyTextで
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenWidth < 600 ? 10 : 20,
              ),
              //回答
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    L10n.answerIconText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).answerIcon),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      questionCardDto.answerText != null
                          ? questionCardDto.answerText!
                          : L10n.noAnswerText,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                          color: ColorSet.of(context).greyText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: screenWidth < 600 ? 15 : 22,
                    backgroundImage: teacherImage,
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
