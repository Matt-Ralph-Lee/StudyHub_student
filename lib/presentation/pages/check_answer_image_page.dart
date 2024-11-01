import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/answer/application_service/answer_dto.dart';
import '../controllers/get_photo_controller/get_photo_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class CheckAnswerImagePage extends HookConsumerWidget {
  final AnswerDto answerDto;
  final int order;
  const CheckAnswerImagePage({
    super.key,
    required this.answerDto,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dousuru = useState(1);
    final currentPage = useState(order);
    PageController pageController = PageController(initialPage: order);
    TransformationController imageController = TransformationController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    void changeDousuru() {
      if (dousuru.value == 0) {
        dousuru.value = 1;
      } else if (dousuru.value == 1) {
        dousuru.value = 0;
      }
    }

    void changeDousurunrun() {
      if (dousuru.value != 2) {
        dousuru.value = 2;
      } else {
        dousuru.value = 1;
      }
    }

    final teacherImage = ref
        .watch(getPhotoControllerProvider(answerDto.teacherProfilePath))
        .maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage("loading_user_icon_light.png")
                : const AssetImage("loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage("assets/images/sample_user_icon.jpg"),
        );

    return orientation == Orientation.portrait
        ? Scaffold(
            backgroundColor: ColorSet.of(context).blackBackground,
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: answerDto.answerPhotoList.length,
                      onPageChanged: (index) {
                        currentPage.value = index;
                      },
                      itemBuilder: (context, index) {
                        final questionImage = ref
                            .watch(getPhotoControllerProvider(
                                answerDto.answerPhotoList[index]))
                            .maybeWhen(
                              data: (d) => d,
                              loading: () {
                                MediaQuery.of(context).platformBrightness ==
                                        Brightness.light
                                    ? const AssetImage(
                                        "loading_user_icon_light.png")
                                    : const AssetImage(
                                        "loading_user_icon_dark.png");
                              },
                              orElse: () => const AssetImage(
                                  "assets/images/no_image.jpg"),
                            );
                        return GestureDetector(
                          onTap: () => changeDousuru(),
                          child: InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 4.0,
                            transformationController: imageController,
                            onInteractionUpdate: (details) {
                              if (imageController.value.getMaxScaleOnAxis() ==
                                  1.0) {
                                dousuru.value = 1;
                              } else {
                                dousuru.value = 0;
                              }
                            },
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image(
                                image: questionImage!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (dousuru.value != 0)
                    Align(
                      alignment: Alignment.topCenter,
                      child: dousuru.value != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: ColorSet.of(context).lightGreyIcon,
                                    size: FontSizeSet.getFontSize(context, 30),
                                  ),
                                  onPressed: () => context.pop(),
                                ),
                                Text(
                                  "${currentPage.value + 1} / ${answerDto.answerPhotoList.length}",
                                  style: TextStyle(
                                    color: ColorSet.of(context).whiteText,
                                    fontWeight: FontWeightSet.semibold,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.body),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: ColorSet.of(context)
                                        .lightGreyIcon
                                        .withOpacity(0),
                                    size: FontSizeSet.getFontSize(context, 30),
                                  ),
                                  onPressed: () => context.pop(),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                    color: ColorSet.of(context).whiteText,
                                    fontWeight: FontWeightSet.semibold,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.body),
                                  ),
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
                            onTap: () => changeDousurunrun(),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: screenWidth < 600 ? 15 : 22,
                                          backgroundImage: teacherImage,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          answerDto.teacherName,
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
                                      answerDto.answerText,
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
                    ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: screenHeight,
            child: PageView.builder(
              controller: pageController,
              itemCount: answerDto.answerPhotoList.length,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              itemBuilder: (BuildContext context, int index) {
                final questionImage = ref
                    .watch(getPhotoControllerProvider(
                        answerDto.answerPhotoList[index]))
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
