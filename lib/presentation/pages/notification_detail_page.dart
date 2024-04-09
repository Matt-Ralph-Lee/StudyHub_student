import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/notification/application_service/get_my_notification_dto.dart';
import '../components/widgets/notification_detail_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class NotificationDetailPage extends HookConsumerWidget {
  final GetMyNotificationDto getMyNotificationDto;
  const NotificationDetailPage({
    super.key,
    required this.getMyNotificationDto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, 30),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          L10n.notificationTitleText,
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).text,
          ),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingSet.getPaddingSize(
            context,
            PaddingSet.horizontalPadding,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationDetailCardWidget(
                getMyNotificationDto: getMyNotificationDto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
