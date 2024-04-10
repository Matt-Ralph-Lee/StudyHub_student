import 'dart:io';

import 'package:flutter/material.dart';

import 'bottom_sheet_for_pick_image.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/color_set.dart';

class CircleAvatarForProfileEdit extends StatelessWidget {
  final String iconUrl;
  final String? imageFilePath;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const CircleAvatarForProfileEdit(
      {super.key,
      required this.iconUrl,
      required this.imageFilePath,
      required this.takePhoto,
      required this.pickPhoto});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: screenWidth < 600 ? 50 : 75,
            backgroundImage: (imageFilePath == null)
                ? AssetImage(iconUrl) as ImageProvider
                : FileImage(File(imageFilePath!)),
          ),
          Positioned(
              bottom: 7,
              right: 7,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => BottomSheetForPickImage(
                          takePhoto: takePhoto,
                          pickPhoto: pickPhoto,
                        )),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  color: ColorSet.of(context).primary,
                  size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
                ),
              ))
        ],
      ),
    );
  }
}
