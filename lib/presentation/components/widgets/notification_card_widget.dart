import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/page_path.dart';

class NotificationCardWidget extends StatelessWidget {
  final GetMyNotificationDto getMyNotificationDto;

  const NotificationCardWidget({super.key, required this.getMyNotificationDto});

  @override
  Widget build(BuildContext context) {
    void navigateToNotificationDetailPage(BuildContext context) {
      context.push(PageId.notificationDetailPage.path,
          extra: getMyNotificationDto);
    }

    return GestureDetector(
      onTap: () => navigateToNotificationDetailPage(context),
      child: Container(
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
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: getMyNotificationDto
                        .sender.senderPhotoPath.value
                        .contains("assets")
                    ? AssetImage(
                            getMyNotificationDto.sender.senderPhotoPath.value)
                        as ImageProvider
                    : NetworkImage(
                        getMyNotificationDto.sender.senderPhotoPath.value,
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
                      getMyNotificationDto.title,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                          color: ColorSet.of(context).text),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(getMyNotificationDto.text,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).text),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
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
