import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application/question/application_service/question_detail_dto.dart';
import '../../shared/constants/page_path.dart';

class QuestionPictureWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    void navigateToCheckQuestionImagePage(BuildContext context) {
      context.push(PageId.checkQuestionImagePage.path, extra: [
        questionDetailDto,
        order,
      ]);
    }

    return GestureDetector(
      onTap: () => navigateToCheckQuestionImagePage(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: photoPath.contains("assets")
            ? Image(
                image: AssetImage(photoPath),
                width: 350,
                fit: BoxFit.contain,
              )
            : Image.network(
                photoPath,
                width: 350,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
