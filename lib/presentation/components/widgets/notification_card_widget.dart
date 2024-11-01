import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/question/models/question_id.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../controllers/read_notification_controller/read_notification_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/utils/handle_error.dart';
import '../../shared/constants/padding_set.dart';
import '../../shared/constants/page_path.dart';
import 'error_modal_widget.dart';

class NotificationCardWidget extends ConsumerWidget {
  final GetMyNotificationDto getMyNotificationDto;

  const NotificationCardWidget({super.key, required this.getMyNotificationDto});

  @override
  Widget build(BuildContext context, ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    void navigateToNotificationDetailPage(BuildContext context) async {
      await ref
          .read(readNotificationControllerProvider.notifier)
          .readNotification(getMyNotificationDto.id);

      if (!context.mounted) return;

      final currentState = ref.read(readNotificationControllerProvider);
      if (currentState.hasError) {
        final error = currentState.error;
        final errorMessage = handleError(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorModalWidget(
              errorMessage: errorMessage,
            );
          },
        );
      }

      context.push(PageId.notificationDetailPage.path,
          extra: getMyNotificationDto);
    }

    void navigateToQuestionAndAnswerPage(BuildContext context) async {
      await ref
          .read(readNotificationControllerProvider.notifier)
          .readNotification(getMyNotificationDto.id);

      if (!context.mounted) return;

      final currentState = ref.read(readNotificationControllerProvider);
      if (currentState.hasError) {
        final error = currentState.error;
        final errorMessage = handleError(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorModalWidget(
              errorMessage: errorMessage,
            );
          },
        );
      }

      context.push(PageId.questionAndAnswerPage.path, extra: [
        getMyNotificationDto.subTargetId as QuestionId,
        false,
      ]);
    }

    final image = ref
        .watch(getPhotoControllerProvider(getMyNotificationDto.senderPhotoPath))
        .maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_light.png")
                : const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage(
              "assets/photos/profile_photo/sample_user_icon.jpg"),
        );

    return GestureDetector(
      onTap: () => getMyNotificationDto.type == NotificationTargetType.answered
          ? navigateToQuestionAndAnswerPage(context)
          : navigateToNotificationDetailPage(context),
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
          padding: EdgeInsets.all(PaddingSet.getPaddingSize(
            context,
            20,
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            getMyNotificationDto.title,
                            style: TextStyle(
                                fontWeight: FontWeightSet.normal,
                                fontSize: FontSizeSet.getFontSize(
                                  context,
                                  FontSizeSet.body,
                                ),
                                color: ColorSet.of(context).text),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!getMyNotificationDto.read)
                          Icon(
                            Icons.circle,
                            color:
                                ColorSet.of(context).errorText.withOpacity(0.9),
                            size: 15,
                          ),
                      ],
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
