import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/notification/application_service/get_my_notification_dto.dart';
import '../../domain/notification/models/notification_target_type.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_notifications_found.dart';
import '../components/parts/text_for_notification_section_header.dart';
import '../components/widgets/notification_card_skeleton_widget.dart';
import '../components/widgets/notification_card_widget.dart';
import '../controllers/get_my_notifications_controller/get_my_notifications_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMyNotificationsState =
        ref.watch(getMyNotificationsControllerProvider);

    List<Widget> processNotifications(
      List<GetMyNotificationDto> getMyNotificationsDto,
      BuildContext context,
    ) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final currentWeekday = today.weekday;
      final firstDayOfWeek = today.subtract(Duration(days: currentWeekday));

      List<Widget> notifications = [];
      var isTodayAdded = false;
      var isThisWeekAdded = false;
      var isLastWeekAdded = false;

      for (var notificationDto in getMyNotificationsDto) {
        final postedAtDateTime = notificationDto.postedAt;
        final postedDate = DateTime(postedAtDateTime.year,
            postedAtDateTime.month, postedAtDateTime.day);

        if (postedDate.isAtSameMomentAs(today) && !isTodayAdded) {
          notifications.add(Padding(
            padding:
                EdgeInsets.only(bottom: PaddingSet.getPaddingSize(context, 15)),
            child: const TextForNotificationSectionHeader(text: L10n.todayText),
          ));
          isTodayAdded = true;
        } else if (postedAtDateTime
                .isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
            postedAtDateTime.isBefore(today) &&
            !isThisWeekAdded) {
          notifications.add(Padding(
            padding:
                EdgeInsets.only(bottom: PaddingSet.getPaddingSize(context, 15)),
            child:
                const TextForNotificationSectionHeader(text: L10n.thisWeekText),
          ));
          isThisWeekAdded = true;
        } else if (postedAtDateTime.isBefore(firstDayOfWeek) &&
            !isLastWeekAdded) {
          notifications.add(Padding(
            padding:
                EdgeInsets.only(bottom: PaddingSet.getPaddingSize(context, 15)),
            child:
                const TextForNotificationSectionHeader(text: L10n.beforeText),
          ));
          isLastWeekAdded = true;
        }

        notifications.add(Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notificationDto.type == NotificationTargetType.answered)
                Column(
                  children: [
                    Text(
                      L10n.answeredNotificationTest,
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        ),
                        color: ColorSet.of(context).primary,
                      ),
                    ),
                    SizedBox(
                      height: PaddingSet.getPaddingSize(context, 15),
                    ),
                  ],
                ),
              if (notificationDto.type == NotificationTargetType.info)
                Column(
                  children: [
                    Text(
                      L10n.infoText,
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        ),
                        color: ColorSet.of(context).primary,
                      ),
                    ),
                    SizedBox(
                      height: PaddingSet.getPaddingSize(context, 15),
                    ),
                  ],
                ),
              NotificationCardWidget(
                getMyNotificationDto: notificationDto,
              ),
            ],
          ),
        ));
      }

      return notifications;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, 30),
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: PaddingSet.getPaddingSize(
            context,
            20,
          ),
        ),
        child: RefreshIndicator(
          backgroundColor: ColorSet.of(context).primary,
          color: ColorSet.of(context).whiteText,
          onRefresh: () async {
            HapticFeedback.lightImpact();
            ref.invalidate(getMyNotificationsControllerProvider);
          },
          child: getMyNotificationsState.when(
            data: (getMyNotificationsDto) {
              if (getMyNotificationsDto.isNotEmpty) {
                final notificationsList =
                    processNotifications(getMyNotificationsDto, context);
                return ListView.builder(
                  itemCount: notificationsList.isNotEmpty
                      ? notificationsList.length
                      : 1,
                  itemBuilder: (context, index) {
                    if (notificationsList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: const TextForNoNotificationsFound(),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: PaddingSet.getPaddingSize(
                          context,
                          PaddingSet.horizontalPadding,
                        ),
                      ), //影消さないようにここでpadding入れてる
                      child: notificationsList[index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: TextForNoNotificationsFound(),
                );
              }
            },
            loading: () => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingSet.getPaddingSize(
                    context,
                    PaddingSet.horizontalPadding,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: NotificationCardSkeletonWidget(),
                ),
              ),
            ),
            error: (error, stack) {
              return const Center(
                  child: Column(
                children: [
                  TextForError(),
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
}
