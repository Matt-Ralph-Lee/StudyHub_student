import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class NotificationDetailCardWidget extends ConsumerWidget {
  final GetMyNotificationDto getMyNotificationDto;

  const NotificationDetailCardWidget({
    super.key,
    required this.getMyNotificationDto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final image = ref
        .watch(getPhotoControllerProvider(getMyNotificationDto.senderPhotoPath))
        .maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage("assets/photos/loading_user_icon_light.png")
                : const AssetImage("assets/photos/loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage("assets/photos/sample_user_icon.jpg"),
        );

    return Container(
      width: double.infinity,
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
      ),
      child: Padding(
        padding: EdgeInsets.all(
          screenWidth < 600 ? 20 : 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: screenWidth < 600 ? 15 : 22,
                        backgroundImage: image,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          getMyNotificationDto.title,
                          style: TextStyle(
                            fontWeight: FontWeightSet.semibold,
                            fontSize: FontSizeSet.getFontSize(
                              context,
                              FontSizeSet.body,
                            ),
                            color: ColorSet.of(context).text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Text(
                    getMyNotificationDto.text,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                        context,
                        FontSizeSet.body,
                      ),
                      color: ColorSet.of(context).text,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
