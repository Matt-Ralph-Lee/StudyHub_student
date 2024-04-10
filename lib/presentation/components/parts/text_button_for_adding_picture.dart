import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import 'bottom_sheet_for_pick_image.dart';

class TextButtonForAddingPicture extends StatelessWidget {
  final List<String>? imageFilePath;
  final bool isPicturesAdded;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const TextButtonForAddingPicture({
    Key? key,
    required this.imageFilePath,
    required this.isPicturesAdded,
    required this.takePhoto,
    required this.pickPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: ((builder) => BottomSheetForPickImage(
                takePhoto: takePhoto,
                pickPhoto: pickPhoto,
              )),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: ColorSet.of(context).whiteText,
        disabledForegroundColor: ColorSet.of(context).unselectedText,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.camera,
              size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
              color: ColorSet.of(context).primary),
          const SizedBox(
            width: 10,
          ),
          Text(
            isPicturesAdded
                ? L10n.changeImagesButtonText
                : L10n.addImagesButtonText,
            style: TextStyle(
                fontWeight: isPicturesAdded
                    ? FontWeightSet.semibold
                    : FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: isPicturesAdded
                    ? ColorSet.of(context).primary
                    : ColorSet.of(context).greyText), //ここの色は迷う
          ),
        ],
      ),
    );
  }
}
