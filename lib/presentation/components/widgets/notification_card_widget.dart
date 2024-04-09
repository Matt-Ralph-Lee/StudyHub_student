import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/controllers/get_photo_controller/get_photo_controller.dart';

import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../../infrastructure/exceptions/notification/notification_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/notification/notification_infrastructure_exception_detail.dart';
import '../../controllers/read_notification_controller/read_notification_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';
import '../../shared/constants/page_path.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class NotificationCardWidget extends ConsumerWidget {
  final GetMyNotificationDto getMyNotificationDto;

  const NotificationCardWidget({super.key, required this.getMyNotificationDto});

  @override
  Widget build(BuildContext context, ref) {
    void navigateToNotificationDetailPage(BuildContext context) {
      context.push(PageId.notificationDetailPage.path,
          extra: getMyNotificationDto);
      ref
          .read(readNotificationControllerProvider.notifier)
          .readNotification(getMyNotificationDto.id)
          .then((_) {
        final currentState = ref.read(readNotificationControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          if (error is NotificationInfrastructureException) {
            final errorText = L10n.readNotificationExceptionMessage(
                error.detail as NotificationInfrastructureExceptionDetail);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SpecificExceptionModalWidget(
                    errorMessage: errorText,
                  );
                });
          } else {
            showErrorModalWidget(context);
          }
        }
      });
    }

    final image = ref
        .watch(getPhotoControllerProvider(getMyNotificationDto.senderPhotoPath))
        .maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/sample_picture_hd.jpg"),
        );

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
          padding: EdgeInsets.all(PaddingSet.getPaddingSize(
            context,
            20,
          )),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
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
                                color: ColorSet.of(context)
                                    .errorText
                                    .withOpacity(0.9),
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
            ],
          ),
        ),
      ),
    );
  }
}
