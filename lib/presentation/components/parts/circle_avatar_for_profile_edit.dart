import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'bottom_sheet_for_pick_image.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/color_set.dart';

class CircleAvatarForProfileEdit extends StatelessWidget {
  final String iconUrl;
  final XFile? imageFile;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const CircleAvatarForProfileEdit(
      {super.key,
      required this.iconUrl,
      required this.imageFile,
      required this.takePhoto,
      required this.pickPhoto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: (imageFile == null)
                ? NetworkImage(iconUrl) as ImageProvider
                : FileImage(File(imageFile!.path)),
          ),
          Positioned(
              bottom: 10,
              right: 10,
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
