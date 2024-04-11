import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TeacherSmallCardWidget extends ConsumerWidget {
  final String name;
  final String bio;
  final String iconUrl;
  final bool isSelected;
  final void Function() onTap;

  const TeacherSmallCardWidget({
    super.key,
    required this.name,
    required this.bio,
    required this.iconUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final image = ref.watch(getPhotoControllerProvider(iconUrl)).maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage("assets/photos/loading_user_icon_light.png")
                : const AssetImage("assets/photos/loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage("assets/photos/sample_user_icon.jpg"),
        );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorSet.of(context).surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: ColorSet.of(context).cardShadow,
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 0)),
          ],
          border: isSelected
              ? Border.all(
                  color: ColorSet.of(context).primary,
                  width: 1,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //webだと？表示されない？？手元のシュミレーター動かないのでとりまこのままで <= internetが理由だよ assetsだったら、AssetImage使うっていう応急処置取ってるよ
              CircleAvatar(
                radius: screenWidth < 600 ? 15 : 22,
                backgroundImage: image,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                          color: ColorSet.of(context).text),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bio,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.body,
                          ),
                          color: ColorSet.of(context).text),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
