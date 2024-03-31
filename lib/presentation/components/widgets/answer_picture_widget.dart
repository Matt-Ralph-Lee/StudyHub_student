import 'package:flutter/widgets.dart';

class AnswerPictureWidget extends StatelessWidget {
  final String photoPath;
  const AnswerPictureWidget({
    super.key,
    required this.photoPath,
  });

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
