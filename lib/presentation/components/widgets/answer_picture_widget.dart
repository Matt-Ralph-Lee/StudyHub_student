import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/controllers/get_photo_controller/get_photo_controller.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../shared/constants/page_path.dart';

class AnswerPictureWidget extends ConsumerWidget {
  final AnswerDto answerDto;
  final String photoPath;
  final int order;
  const AnswerPictureWidget(
      {super.key,
      required this.answerDto,
      required this.photoPath,
      required this.order});

  void navigateToCheckQuestionImagePage(BuildContext context) {
    context.push(PageId.checkAnswerImagePage.path, extra: [
      answerDto,
      order,
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final image = ref.watch(getPhotoControllerProvider(photoPath)).maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/no_image.jpg"),
        );
    return GestureDetector(
      onTap: () => navigateToCheckQuestionImagePage(
        context,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image(
          image: image,
          height: screenWidth < 600 ? 200 : 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
