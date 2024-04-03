import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../shared/constants/page_path.dart';

class AnswerPictureWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToCheckQuestionImagePage(
        context,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: photoPath.contains("assets")
            ? Image(
                image: AssetImage(photoPath),
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              )
            : Image.network(
                photoPath,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
