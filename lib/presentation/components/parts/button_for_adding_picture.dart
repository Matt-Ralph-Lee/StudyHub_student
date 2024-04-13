// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';

// import '../../shared/constants/color_set.dart';
// import '../../shared/constants/font_size_set.dart';

// import 'bottom_sheet_for_pick_image.dart';

// class ButtonForAddingPicture extends StatelessWidget {
//   final List<String>? imageFilePath;
//   final bool isPicturesAdded;
//   final void Function() takePhoto;
//   final void Function() pickPhoto;
//   final void Function(String)? deletePhoto;

//   const ButtonForAddingPicture({
//     Key? key,
//     required this.imageFilePath,
//     required this.isPicturesAdded,
//     required this.takePhoto,
//     required this.pickPhoto,
//     required this.deletePhoto,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: ((builder) => BottomSheetForPickImage(
//                 imageFilePath: imageFilePath,
//                 takePhoto: takePhoto,
//                 pickPhoto: pickPhoto,
//                 deletePhoto: deletePhoto,
//               )),
//         );
//       },
//       child: DottedBorder(
//         color: ColorSet.of(context).primary,
//         borderType: BorderType.RRect,
//         radius: const Radius.circular(10),
//         dashPattern: const [5.0, 2.0],
//         strokeWidth: 1.0,
//         child: Container(
//           alignment: Alignment.center,
//           width: screenWidth < 600 ? 150 : 225,
//           height: screenWidth < 600 ? 150 : 225,
//           child: Icon(
//             Icons.add_a_photo_rounded,
//             size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
//             color: ColorSet.of(context).primary,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import 'bottom_sheet_for_pick_image.dart';

class ButtonForAddingPicture extends StatelessWidget {
  final List<String>? imageFilePath;
  final bool isPicturesAdded;
  final void Function() takePhoto;
  final void Function() pickPhoto;
  final void Function(String)? deletePhoto;

  const ButtonForAddingPicture({
    Key? key,
    required this.imageFilePath,
    required this.isPicturesAdded,
    required this.takePhoto,
    required this.pickPhoto,
    required this.deletePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: ((builder) => BottomSheetForPickImage(
                imageFilePath: imageFilePath,
                takePhoto: takePhoto,
                pickPhoto: pickPhoto,
                deletePhoto: deletePhoto,
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
