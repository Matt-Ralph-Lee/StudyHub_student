import 'package:flutter/material.dart';

class QuestionPictureWidget extends StatelessWidget {
  final String photoPath;

  const QuestionPictureWidget({
    Key? key,
    required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}
