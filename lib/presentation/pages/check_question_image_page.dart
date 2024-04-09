import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/question/application_service/question_detail_dto.dart';
import '../controllers/get_photo_controller/get_photo_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class CheckQuestionImagePage extends HookConsumerWidget {
  final QuestionDetailDto questionDetailDto;
  final int order;
  const CheckQuestionImagePage({
    super.key,
    required this.questionDetailDto,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dousuru = useState(1);
    final currentPage = useState(order);
    PageController pageController = PageController(initialPage: order);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    void changeDousuru() {
      if (dousuru.value == 0) {
        dousuru.value = 1;
      } else if (dousuru.value == 1) {
        dousuru.value = 0;
      } else if (dousuru.value == 2) {
        dousuru.value = 1;
      }
    }

    final studentImage = ref
        .watch(getPhotoControllerProvider(
            questionDetailDto.studentProfilePhotoPath))
        .maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/no_image.jpg"),
        );

    return orientation == Orientation.portrait
        ? Scaffold(
            backgroundColor: ColorSet.of(context).blackBackground,
            appBar: AppBar(
                leading: dousuru.value != 0
                    ? IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: ColorSet.of(context).lightGreyIcon,
                          size: FontSizeSet.getFontSize(context, 30),
                        ),
                        onPressed: () => context.pop(),
                      )
                    : SizedBox(
                        height: FontSizeSet.getFontSize(context, 30),
                      ),
                centerTitle: true,
                title: dousuru.value != 0
                    ? Text(
                        "${currentPage.value + 1} / ${questionDetailDto.questionPhotoPathList.length}",
                        style: TextStyle(
                          color: ColorSet.of(context).whiteText,
                          fontWeight: FontWeightSet.semibold,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                        ),
                      )
                    : null),
            body: GestureDetector(
              onTap: () {
                changeDousuru();
              },
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: const Alignment(0, -0.5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height:
                              screenWidth < 600 ? 300 : 500, //ここ適当、ipadレスポンシブ
                          child: PageView.builder(
                            controller: pageController,
                            itemCount:
                                questionDetailDto.questionPhotoPathList.length,
                            onPageChanged: (index) {
                              currentPage.value = index;
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final questionImage = ref
                                  .watch(getPhotoControllerProvider(
                                      questionDetailDto
                                          .questionPhotoPathList[index]))
                                  .maybeWhen(
                                    data: (d) => d,
                                    orElse: () => const AssetImage(
                                        "assets/images/sample_picture_hd.jpg"),
                                  );
                              return Image(
                                image: questionImage,
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: currentPage.value > 0
                                    ? ColorSet.of(context).whiteText
                                    : ColorSet.of(context).greyText,
                              ),
                              onPressed: () {
                                currentPage.value > 0
                                    ? pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      )
                                    : null;
                              },
                            ),
                            const SizedBox(width: 100),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: currentPage.value <
                                        (questionDetailDto
                                                .questionPhotoPathList.length -
                                            1)
                                    ? ColorSet.of(context).whiteText
                                    : ColorSet.of(context).greyText,
                              ),
                              onPressed: () {
                                currentPage.value <
                                        (questionDetailDto
                                                .questionPhotoPathList.length -
                                            1)
                                    ? pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      )
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (dousuru.value != 0)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          constraints: dousuru.value == 2
                              ? BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.8)
                              : null,
                          color: ColorSet.of(context)
                              .blackBackground
                              .withOpacity(0.5),
                          child: GestureDetector(
                            onTap: () {
                              dousuru.value = 2;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: studentImage,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          questionDetailDto.questionTitle,
                                          style: TextStyle(
                                            color:
                                                ColorSet.of(context).whiteText,
                                            fontWeight: FontWeightSet.semibold,
                                            fontSize: FontSizeSet.getFontSize(
                                                context, FontSizeSet.body),
                                          ),
                                          maxLines:
                                              dousuru.value == 2 ? null : 1,
                                          overflow: dousuru.value == 2
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      questionDetailDto.questionText,
                                      style: TextStyle(
                                        color: ColorSet.of(context).whiteText,
                                        fontWeight: FontWeightSet.normal,
                                        fontSize: FontSizeSet.getFontSize(
                                            context, FontSizeSet.body),
                                      ),
                                      maxLines: dousuru.value == 2 ? null : 2,
                                      overflow: dousuru.value == 2
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    )
                ],
              ),
            ),
          )
        : SizedBox(
            height: screenHeight,
            child: PageView.builder(
              controller: pageController,
              itemCount: questionDetailDto.questionPhotoPathList.length,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              itemBuilder: (BuildContext context, int index) {
                final questionImage = ref
                    .watch(getPhotoControllerProvider(
                        questionDetailDto.questionPhotoPathList[index]))
                    .maybeWhen(
                      data: (d) => d,
                      orElse: () => const AssetImage(
                          "assets/images/sample_picture_hd.jpg"),
                    );
                return Image(
                  image: questionImage,
                  fit: BoxFit.contain,
                );
              },
            ),
          );
  }
}
