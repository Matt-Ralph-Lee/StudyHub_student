import 'package:flutter/material.dart';

import '../../../application/teacher_evaluation/application_service/get_teacher_evaluation_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class EvaluationsWidget extends StatelessWidget {
  final List<GetTeacherEvaluationDto> teacherEvaluationsDto;

  const EvaluationsWidget({
    Key? key,
    required this.teacherEvaluationsDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text("生徒からの評価",
        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.header3),
                            color: ColorSet.of(context).greyText,
                          ),
                          ),
        const SizedBox(height: 20,),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: teacherEvaluationsDto.length,
          itemBuilder: (context, index) {
            return Container(
        height: screenWidth < 600 ? 155 : 220,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      teacherEvaluationsDto[index]., //生徒の写真はどうやって取得する？
                    ),
                  ),
                  Text(
                    teacherEvaluationsDto[index]., //日時はどうやって取得する？
                  style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.header3),
                            color: ColorSet.of(context).text,
                          ),), 
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          teacherEvaluationsDto[index].comment,
                          style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.header3),
                            color: ColorSet.of(context).text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
            );
          },
        ),
      ],
    );
  }
}
