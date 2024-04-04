import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../application/question/application_service/question_detail_dto.dart';
import '../../../domain/question/models/question_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class QuestionDetailCardWidget extends StatelessWidget {
  final QuestionDetailDto questionDetailDto;

  const QuestionDetailCardWidget({
    super.key,
    required this.questionDetailDto,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void navigateToReportPage(BuildContext context, QuestionId questionId) {
      context.push(
        PageId.reportQuestionPage.path,
        extra: [
          questionId,
          null,
        ],
      );
    }

    return Container(
      // width: screenWidth * 0.8, //ここ適当。
      width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: questionDetailDto
                                .studentProfilePhotoPath
                                .contains("assets")
                            ? AssetImage(
                                    questionDetailDto.studentProfilePhotoPath)
                                as ImageProvider
                            : NetworkImage(
                                questionDetailDto.studentProfilePhotoPath,
                              ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          questionDetailDto.questionTitle,
                          style: TextStyle(
                            fontWeight: FontWeightSet.semibold,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.header3),
                            color: ColorSet.of(context).text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                //元祖StudyHubから移植。モーダルだと位置調整だるそうなので。いらないプロパティありそうだけど放置！
                PopupMenuButton<String>(
                  color: ColorSet.of(context).greySurface,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: ColorSet.of(context).text,
                    size: FontSizeSet.getFontSize(context, FontSizeSet.header2),
                  ),
                  onSelected: (String result) {
                    if (result == L10n.reportText) {
                      navigateToReportPage(
                        context,
                        questionDetailDto.questionId,
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: L10n.reportText,
                      child: Text(
                        L10n.reportText,
                        style: TextStyle(
                          color: ColorSet.of(context).text,
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Text(
                    questionDetailDto.questionText,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
