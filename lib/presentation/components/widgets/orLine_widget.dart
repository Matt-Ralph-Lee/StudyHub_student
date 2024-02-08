import "package:flutter/material.dart";

import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class OrLineWidget extends StatelessWidget {
  const OrLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "or",
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.annotation,
                color: Colors.grey),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
