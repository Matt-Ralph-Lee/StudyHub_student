import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TeacherSmallCardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              ? Border.all(color: ColorSet.of(context).text, width: 2)
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
                radius: 15,
                backgroundImage: iconUrl.contains("assets")
                    ? AssetImage(iconUrl) as ImageProvider
                    : NetworkImage(
                        iconUrl,
                      ),
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
