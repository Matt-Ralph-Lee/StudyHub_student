import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';
import '../../shared/constants/page_path.dart';
import 'rank_description_modal.dart';

//ランクの定義どうする
Map<String, Map<String, dynamic>> createRankRequirements(BuildContext context) {
  return {
    L10n.beginnerText: {
      L10n.questionsText: 3,
      L10n.colorText: ColorSet.of(context).primary
    },
    L10n.noviceText: {
      L10n.questionsText: 6,
      L10n.colorText: ColorSet.of(context).primary.withOpacity(0.7)
    },
    L10n.advancedText: {
      L10n.questionsText: 9,
      L10n.colorText: ColorSet.of(context).primary.withOpacity(0.4)
    },
    L10n.expertText: {
      L10n.questionsText: 12,
      L10n.colorText: ColorSet.of(context).primary.withOpacity(0.1)
    },
  };
}

//現在のランクを受け取って次のランクと必要な質問数を返す関数（とりまここにおいるけどどこにおく？）
Map<String, dynamic> getNextRankInfo(BuildContext context, String currentRank) {
  String nextRank = '';
  int questionsForNextRank = 0;
  final rankRequirements = createRankRequirements(context);
  final List<String> ranks = rankRequirements.keys.toList();

  for (int i = 0; i < ranks.length; i++) {
    if (ranks[i] == currentRank) {
      if (i < ranks.length - 1) {
        nextRank = ranks[i + 1];
        questionsForNextRank = rankRequirements[nextRank]![L10n.questionsText]!;
      }
      break;
    }
  }

  return {
    L10n.nextRankText: nextRank,
    L10n.questionsForNextRankText: questionsForNextRank,
  };
}

void showStatusDescriptionDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Dialog(
          child: RankDescriptionModal(),
        ),
      );
    },
  );
}

class UserDetailWidget extends ConsumerWidget {
  final String userName;
  final String userIconUrl;
  final int numberOfFavoriteTeachers;
  final String userRank;
  final int numberOfQuestions;

  const UserDetailWidget({
    super.key,
    required this.userName,
    required this.userIconUrl,
    required this.numberOfFavoriteTeachers,
    required this.userRank,
    required this.numberOfQuestions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic> nextRankInfo =
        getNextRankInfo(context, userRank);
    final String nextRank = nextRankInfo[L10n.nextRankText];
    final String numberOfQuestionsForNextRank =
        (nextRankInfo[L10n.questionsForNextRankText] - numberOfQuestions)
            .toString();
    final rankRequirements = createRankRequirements(context);
    final Color userRankColor = rankRequirements[userRank]![L10n.colorText];
    final double ratioForNextRank =
        numberOfQuestions / nextRankInfo[L10n.questionsForNextRankText];
    final thisWidth = MediaQuery.of(context).size.width -
        PaddingSet.getPaddingSize(
          context,
          20,
        );

    void navigateToFavoriteTeacherPage(BuildContext context) {
      context.push(PageId.favoriteTeachers.path);
    }

    void navigateToEditProfilePage(BuildContext context) {
      context.push(PageId.editProfile.path);
    }

    final image = ref.watch(getPhotoControllerProvider(userIconUrl)).maybeWhen(
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => navigateToEditProfilePage(context),
              child: CircleAvatar(
                radius: screenWidth < 600 ? 45 : 45,
                backgroundImage: image,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => navigateToFavoriteTeacherPage(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, //centerかendか
                  children: [
                    Text(
                      numberOfFavoriteTeachers.toString(),
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                          color: ColorSet.of(context).text),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      L10n.favoriteTeacherText,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.annotation),
                          color: ColorSet.of(context).text),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: ColorSet.of(context).text,
                      size: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => navigateToEditProfilePage(context),
                child: Text(
                  userName,
                  style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.header2),
                      color: ColorSet.of(context).text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: userRankColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Shimmer.fromColors(
                  loop: 1,
                  baseColor: ColorSet.of(context).whiteText,
                  highlightColor: ColorSet.of(context).simmerHighlight,
                  period: const Duration(milliseconds: 1500),
                  child: Text(
                    userRank,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.annotation),
                      color: ColorSet.of(context).whiteText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Container(
              height: 5,
              width: thisWidth,
              decoration: BoxDecoration(
                color: ColorSet.of(context).greySurface,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 5,
              width: thisWidth * ratioForNextRank,
              decoration: BoxDecoration(
                color: ColorSet.of(context).primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Icon(
                Icons.help_outline,
                color: ColorSet.of(context).greyText,
                size: 15,
              ),
              onTap: () {
                showStatusDescriptionDialog(context);
              },
            ),
            const SizedBox(
              width: 5,
            ),
            userRank != L10n.expertText
                ? Row(
                    children: [
                      Text(
                        "$nextRank${L10n.madeText}",
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                              context,
                              FontSizeSet.annotation,
                            ),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        numberOfQuestionsForNextRank, //若干隣の文字より上に上がってるんよな、数字だから？？
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                              context,
                              FontSizeSet.annotation,
                            ),
                            color: ColorSet.of(context).greyText),
                      ),
                    ],
                  )
                : Text(
                    L10n.expertDesuyoText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.annotation,
                        ),
                        color: ColorSet.of(context).greyText),
                  ),
          ],
        ),
      ],
    );
  }
}
