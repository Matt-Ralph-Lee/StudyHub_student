import 'package:flutter/material.dart';

class QuestionPicturesWidget extends StatelessWidget {
  final List<String> photoPaths;

  const QuestionPicturesWidget({
    Key? key,
    required this.photoPaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photoPaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                photoPaths[index],
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
