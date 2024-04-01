import 'package:flutter/material.dart';

class QuestionPictureForConfirmWidget extends StatelessWidget {
  final String photoPath;

  const QuestionPictureForConfirmWidget({
    Key? key,
    required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        photoPath,
        width: 200,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
