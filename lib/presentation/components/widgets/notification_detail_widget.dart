import 'package:flutter/material.dart';
import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class NotificationDetailCardWidget extends StatelessWidget {
  final GetMyNotificationDto getMyNotificationDto;

  const NotificationDetailCardWidget({
    super.key,
    required this.getMyNotificationDto,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: getMyNotificationDto
                                .sender.senderPhotoPath.value
                                .contains("assets")
                            ? AssetImage(getMyNotificationDto
                                .sender.senderPhotoPath.value) as ImageProvider
                            : NetworkImage(
                                getMyNotificationDto
                                    .sender.senderPhotoPath.value,
                              ),
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
                                context, FontSizeSet.header3),
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
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
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
