import 'dart:io';

import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import 'bottom_sheet_for_pick_image.dart';

class ButtonForAddingProfileImage extends StatelessWidget {
  final bool isPicturesAdded;
  final void Function() takePhoto;
  final void Function() pickPhoto;
  final String selectedPhoto;

  const ButtonForAddingProfileImage({
    Key? key,
    required this.isPicturesAdded,
    required this.takePhoto,
    required this.pickPhoto,
    required this.selectedPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              L10n.userProfileImageInputLabelText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.annotation),
                  color: ColorSet.of(context).greyText),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              CircleAvatar(
                radius: screenWidth < 600 ? 70 : 100,
                backgroundImage: selectedPhoto.isNotEmpty
                    ? FileImage(File(selectedPhoto)) as ImageProvider<Object>?
                    : const AssetImage(
                        "assets/photos/profile_photo/sample_user_icon.jpg"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => BottomSheetForPickImage(
                            takePhoto: takePhoto,
                            pickPhoto: pickPhoto,
                          )),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorSet.of(context).greySurface,
                    child: Icon(
                      Icons.edit,
                      size:
                          FontSizeSet.getFontSize(context, FontSizeSet.header1),
                      color: ColorSet.of(context).primary,
                    ),
                  ),
                ),
              )
              /*
              Positioned(
                bottom: 0,
                right: 0,
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  child: Icon(Icons.camera,
                      size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
                      color: ColorSet.of(context).primary),
                ),
              ),
              */
            ]),
          ],
        ),
      ],
    );
  }
}
