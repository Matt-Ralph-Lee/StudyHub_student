import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
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

class UserDetailWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
    final thisWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: userIconUrl.contains("assets")
                  ? AssetImage(userIconUrl) as ImageProvider
                  : NetworkImage(userIconUrl),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //favorite_teacher_pageマージしたらonTap時にそこ飛ぶように加筆する
                children: [
                  Text(
                    numberOfFavoriteTeachers.toString(),
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                  ),
                  const SizedBox(
                    width: 5,
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
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userName,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.header2),
                  color: ColorSet.of(context).text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              decoration: BoxDecoration(
                color: userRankColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  userRank,
                  style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.annotation),
                      color: ColorSet.of(context).whiteText),
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
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                showStatusDescriptionDialog(context);
              },
              color: ColorSet.of(context).greyText,
              iconSize: 15,
            ),
            /*
            const SizedBox(
              width: 5,
            ),
            */
            Text(
              "$nextRank${L10n.madeText}",
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.annotation),
                  color: ColorSet.of(context).greyText),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              numberOfQuestionsForNextRank,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.annotation),
                  color: ColorSet.of(context).greyText),
            ),
          ],
        ),
      ],
    );
  }
}
