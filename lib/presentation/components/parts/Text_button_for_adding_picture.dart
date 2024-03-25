import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import 'bottom_sheet_for_pick_image.dart';

class TextButtonForAddingPicture extends StatelessWidget {
  final List<String>? imageFilePath;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const TextButtonForAddingPicture({
    Key? key,
    required this.imageFilePath,
    required this.takePhoto,
    required this.pickPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
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
        ),
        child: Row(
          children: [
            Icon(Icons.camera,
                size: FontSizeSet.header1, color: ColorSet.of(context).primary),
            SizedBox(
              width: 10,
            ),
            Text(
              "写真を追加",
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.body,
                  color: ColorSet.of(context).greyText), //ここの色は迷う
            ),
          ],
        ),
      ),
    );
  }
}
