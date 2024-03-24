import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import 'bottom_sheet_for_pick_image.dart';

class ElevatedButtonForAddingPicture extends StatelessWidget {
  final List<String>? imageFilePath;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const ElevatedButtonForAddingPicture({
    Key? key,
    required this.imageFilePath,
    required this.takePhoto,
    required this.pickPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => BottomSheetForPickImage(
                  takePhoto: takePhoto,
                  pickPhoto: pickPhoto,
                )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorSet.of(context).primary,
          disabledBackgroundColor: ColorSet.of(context).inactiveGreySurface,
          foregroundColor: ColorSet.of(context).whiteText,
          disabledForegroundColor: ColorSet.of(context).unselectedText,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          "写真を追加する",
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.annotation,
          ),
        ),
      ),
    );
  }
}
