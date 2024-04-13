import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../widgets/question_pictures_for_confirm_widget.dart';

class BottomSheetForPickImage extends StatelessWidget {
  final List<String>? imageFilePath;
  final void Function() takePhoto;
  final void Function() pickPhoto;
  final void Function(String)? deletePhoto;
  const BottomSheetForPickImage({
    super.key,
    this.imageFilePath,
    required this.takePhoto,
    required this.pickPhoto,
    required this.deletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: imageFilePath?.isEmpty == true ? 100 : 300,
      width: screenWidth,
      decoration: BoxDecoration(
          color: ColorSet.of(context).background,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (imageFilePath?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageFilePath!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: QuestionPictureForConfirmWidget(
                                    photoPath: imageFilePath![index],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        deletePhoto!(imageFilePath![index]),
                                    child: Icon(
                                      Icons.cancel,
                                      color: ColorSet.of(context).primary,
                                      size: FontSizeSet.getFontSize(
                                        context,
                                        FontSizeSet.header2,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: takePhoto,
                icon: Icon(
                  Icons.camera,
                  color: ColorSet.of(context).primary,
                  size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
                ),
                label: Text(
                  L10n.takePictureText,
                  style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text),
                ),
              ),
              TextButton.icon(
                onPressed: pickPhoto,
                icon: Icon(
                  Icons.image,
                  color: ColorSet.of(context).primary,
                  size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
                ),
                label: Text(
                  L10n.selectPictureFromGalleryText,
                  style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
