import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/application/question/application_service/question_detail_dto.dart';
import 'package:studyhub/presentation/shared/constants/font_weight_set.dart';

import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';

class CheckQuestionImagePage extends HookWidget {
  final QuestionDetailDto questionDetailDto;
  final int order;
  const CheckQuestionImagePage({
    super.key,
    required this.questionDetailDto,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final currentPage = useState(order);
    final CarouselController controller = CarouselController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, 30),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${currentPage.value + 1} / ${questionDetailDto.questionPhotoPathList.length}",
                    style: TextStyle(
                      color: ColorSet.of(context).text,
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //なんかボタン押しても動かないしスライドもできないのはなぜ!
                  CarouselSlider.builder(
                    itemCount: questionDetailDto.questionPhotoPathList.length,
                    options: CarouselOptions(
                      height: 300.0,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      initialPage: order,
                      onPageChanged: (index, reason) {
                        currentPage.value = index;
                      },
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Image.asset(
                          questionDetailDto.questionPhotoPathList[itemIndex],
                          fit: BoxFit.cover,
                          width: screenWidth,
                        ),
                      ),
                    ),
                    carouselController: controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.previousPage();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: ColorSet.of(context).text,
                        ),
                      ),
                      const SizedBox(width: 30),
                      IconButton(
                        onPressed: () {
                          controller.nextPage();
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: ColorSet.of(context).text,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          AnimatedOpacity(
            opacity: isExpanded.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: () {
                if (isExpanded.value) {
                  isExpanded.value = false;
                }
              },
              child: Container(
                height: screenHeight,
                width: screenWidth,
                color: ColorSet.of(context).background.withOpacity(0.5),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              constraints: isExpanded.value
                  ? BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8)
                  : null,
              color: ColorSet.of(context).background,
              child: isExpanded.value
                  ? GestureDetector(
                      onTap: () => isExpanded.value = !isExpanded.value,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: questionDetailDto
                                            .studentProfilePhotoPath
                                            .contains("assets")
                                        ? AssetImage(questionDetailDto
                                                .studentProfilePhotoPath)
                                            as ImageProvider
                                        : NetworkImage(
                                            questionDetailDto
                                                .studentProfilePhotoPath,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    questionDetailDto.questionTitle,
                                    style: TextStyle(
                                      color: ColorSet.of(context).text,
                                      fontWeight: FontWeightSet.semibold,
                                      fontSize: FontSizeSet.getFontSize(
                                          context, FontSizeSet.body),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                questionDetailDto.questionText,
                                style: TextStyle(
                                  color: ColorSet.of(context).text,
                                  fontWeight: FontWeightSet.normal,
                                  fontSize: FontSizeSet.getFontSize(
                                      context, FontSizeSet.body),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => isExpanded.value = true,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundImage: questionDetailDto
                                          .studentProfilePhotoPath
                                          .contains("assets")
                                      ? AssetImage(questionDetailDto
                                              .studentProfilePhotoPath)
                                          as ImageProvider
                                      : NetworkImage(
                                          questionDetailDto
                                              .studentProfilePhotoPath,
                                        ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  questionDetailDto.questionTitle,
                                  style: TextStyle(
                                    color: ColorSet.of(context).text,
                                    fontWeight: FontWeightSet.semibold,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.body),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              questionDetailDto.questionText,
                              style: TextStyle(
                                color: ColorSet.of(context).text,
                                fontWeight: FontWeightSet.normal,
                                fontSize: FontSizeSet.getFontSize(
                                    context, FontSizeSet.body),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
