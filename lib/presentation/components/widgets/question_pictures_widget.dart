import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/question/application_service/question_detail_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/page_path.dart';

class QuestionPictureWidget extends ConsumerWidget {
  final String photoPath;
  final int order;
  final QuestionDetailDto questionDetailDto;

  const QuestionPictureWidget({
    Key? key,
    required this.photoPath,
    required this.order,
    required this.questionDetailDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToCheckQuestionImagePage(BuildContext context) {
      context.push(PageId.checkQuestionImagePage.path, extra: [
        questionDetailDto,
        order,
      ]);
    }

    final image = ref.watch(getPhotoControllerProvider(photoPath)).maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/sample_picture_hd.jpg"),
        );

    return GestureDetector(
      onTap: () => navigateToCheckQuestionImagePage(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image(
          image: image,
          width: 350,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
