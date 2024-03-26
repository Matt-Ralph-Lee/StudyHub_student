import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/parts/text_for_notification_section_header.dart';
import '../components/widgets/notification_card_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//notificationのdto的なやつ（まだ定義されてないよね？）ちゃんと定義されたら差し替える
class Notification {
  final Timestamp postedAt;
  final String title;
  final String content;
  final String iconUrl;

  Notification(
      {required this.postedAt,
      required this.title,
      required this.content,
      required this.iconUrl});
}

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentWeekday = today.weekday;
    final firstDayOfWeek = today.subtract(Duration(days: currentWeekday));
    var isTodayAdded = false;
    var isThisWeekAdded = false;
    var isLastWeekAdded = false;
    List<Widget> notifications = [];

    //以下はテストのための例。データ取れるようになったら差し替える（decreasingでリストもらう）
    final today1 = Timestamp.fromDate(DateTime(2024, 3, 5, 10, 30));
    final today2 = Timestamp.fromDate(DateTime(2024, 3, 5, 20, 45));
    final thisWeek1 = Timestamp.fromDate(DateTime(2024, 3, 4, 12, 0));
    final thisWeek2 = Timestamp.fromDate(DateTime(2024, 3, 3, 15, 30));
    final lastWeek1 = Timestamp.fromDate(DateTime(2024, 2, 25, 9, 15));
    final lastWeek2 = Timestamp.fromDate(DateTime(2024, 2, 27, 18, 0));
    final List<Notification> notificationsTest = [
      Notification(
          postedAt: today1,
          title: "今日のお知らせ1今日のお知らせ1今日のお知らせ1今日のお知らせ1v今日のお知らせ1今日のお知らせ1今日のお知らせ1",
          iconUrl: "iconUrl",
          content:
              "今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です今日のお知らせ1です"),
      Notification(
          postedAt: today2,
          title: "今日のお知らせ2",
          iconUrl: "iconUrl",
          content: "今日のお知らせ2です"),
      Notification(
          postedAt: thisWeek1,
          title: "今週のお知らせ1",
          iconUrl: "iconUrl",
          content: "今週のお知らせ1です"),
      Notification(
          postedAt: thisWeek2,
          title: "今週のお知らせ2",
          iconUrl: "iconUrl",
          content: "今週のお知らせ2です"),
      Notification(
          postedAt: lastWeek1,
          title: "先週のお知らせ1",
          iconUrl: "iconUrl",
          content: "先週のお知らせ1です"),
      Notification(
          postedAt: lastWeek2,
          title: "先週のお知らせ2",
          iconUrl: "iconUrl",
          content: "先週のお知らせ2です"),
    ];

    for (var notification in notificationsTest) {
      final postedAtDateTime = notification.postedAt.toDate();
      final postedDate = DateTime(
          postedAtDateTime.year, postedAtDateTime.month, postedAtDateTime.day);

      if (postedDate.isAtSameMomentAs(today) && !isTodayAdded) {
        notifications.add(Padding(
          padding: EdgeInsets.only(
              top: PaddingSet.getPaddingSize(
            context,
            40,
          )),
          child: const TextForNotificationSectionHeader(text: L10n.todayText),
        ));
        isTodayAdded = true;
      } else if (postedAtDateTime
              .isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
          postedAtDateTime.isBefore(today) &&
          !isThisWeekAdded) {
        notifications.add(Padding(
          padding: EdgeInsets.only(
              top: PaddingSet.getPaddingSize(
            context,
            40,
          )),
          child:
              const TextForNotificationSectionHeader(text: L10n.thisWeekText),
        ));
        isThisWeekAdded = true;
      } else if (postedAtDateTime.isBefore(firstDayOfWeek) &&
          !isLastWeekAdded) {
        notifications.add(Padding(
          padding: EdgeInsets.only(
              top: PaddingSet.getPaddingSize(
            context,
            40,
          )),
          child: const TextForNotificationSectionHeader(text: L10n.beforeText),
        ));
        isLastWeekAdded = true;
      }

      notifications.add(Padding(
        padding: const EdgeInsets.only(top: 20),
        child: NotificationCardWidget(
          title: notification.title,
          content: notification.content,
          iconUrl: notification.iconUrl,
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          L10n.notificationTitleText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.body,
              ),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: notifications[index],
        ),
      ),
    );
  }
}
