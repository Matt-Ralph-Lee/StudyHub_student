import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class BottomSheetForPickImage extends StatelessWidget {
  final void Function() takePhoto;
  final void Function() pickPhoto;
  const BottomSheetForPickImage(
      {super.key, required this.takePhoto, required this.pickPhoto});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: screenWidth,
      decoration: BoxDecoration(
          color: ColorSet.of(context).background,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto;
                },
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
                onPressed: () {
                  pickPhoto;
                },
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
