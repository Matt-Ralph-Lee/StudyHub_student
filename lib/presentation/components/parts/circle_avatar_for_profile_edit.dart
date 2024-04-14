import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/get_photo_controller/get_photo_controller.dart';
import 'bottom_sheet_for_pick_image.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/color_set.dart';

class CircleAvatarForProfileEdit extends ConsumerWidget {
  final String? imageFilePath;
  final String currentImagePath;
  final void Function() takePhoto;
  final void Function() pickPhoto;

  const CircleAvatarForProfileEdit(
      {super.key,
      required this.imageFilePath,
      required this.currentImagePath,
      required this.takePhoto,
      required this.pickPhoto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final image = ref
        .watch(getPhotoControllerProvider(currentImagePath))
        .maybeWhen(
            data: (d) => d,
            orElse: () => const AssetImage(
                "assets/photos/profile_photo/sample_user_icon.jpg"));
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: screenWidth < 600 ? 50 : 75,
            backgroundImage: (imageFilePath == null)
                ? image
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
                          deletePhoto: null,
                        )),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: FontSizeSet.getFontSize(
                        context,
                        FontSizeSet.header3,
                      ),
                      backgroundColor: ColorSet.of(context).greySurface,
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: ColorSet.of(context).primary,
                      size:
                          FontSizeSet.getFontSize(context, FontSizeSet.header1),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
