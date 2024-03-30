import 'package:flutter/material.dart';
import '../../../application/question/application_service/question_detail_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class QuestionDetailCardWidget extends StatelessWidget {
  final QuestionDetailDto questionDetailDto;

  const QuestionDetailCardWidget({
    super.key,
    required this.questionDetailDto,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
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
        padding: EdgeInsets.all(
          screenWidth < 600 ? 20 : 40,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                questionDetailDto.studentProfilePhotoPath,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    questionDetailDto.questionTitle,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.header3),
                      color: ColorSet.of(context).text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    questionDetailDto.questionText,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class QuestionDetailCardWidget extends StatelessWidget {
//   final QuestionDetailDto questionDetailDto;

//   const QuestionDetailCardWidget({
//     super.key,
//     required this.questionDetailDto,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       height: screenWidth < 600 ? 155 : 220,
//       decoration: BoxDecoration(
//         color: ColorSet.of(context).surface,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//               color: ColorSet.of(context).cardShadow,
//               spreadRadius: 0,
//               blurRadius: 16,
//               offset: const Offset(0, 0)),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(
//           screenWidth < 600 ? 20 : 40,
//         ),
//         child: Row(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 15,
//                   backgroundImage: NetworkImage(
//                     questionDetailDto.studentProfilePhotoPath,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         questionDetailDto.questionTitle,
//                         style: TextStyle(
//                           fontWeight: FontWeightSet.normal,
//                           fontSize: FontSizeSet.getFontSize(
//                               context, FontSizeSet.header3),
//                           color: ColorSet.of(context).text,
//                         ),
//                         // maxLines: 1,
//                         // overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           questionDetailDto.questionText,
//                           style: TextStyle(
//                             fontWeight: FontWeightSet.normal,
//                             fontSize: FontSizeSet.getFontSize(
//                                 context, FontSizeSet.body),
//                             color: ColorSet.of(context).text,
//                           ),
//                           // maxLines: 2,
//                           // overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
