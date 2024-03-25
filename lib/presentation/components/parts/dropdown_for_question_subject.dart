import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/shared/subject.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class DropDownForQuestionSubject extends HookWidget {
  final void Function(Subject?) setSubject;
  const DropDownForQuestionSubject({
    super.key,
    required this.setSubject,
  });

  @override
  Widget build(BuildContext context) {
    final selectedSubject = useState<Subject?>(null);
    return SizedBox(
      width: double.infinity,
      child: DropdownButton<Subject>(
        isExpanded: true,
        value: selectedSubject.value,
        underline: Container(),
        dropdownColor: ColorSet.of(context).surface,
        borderRadius: BorderRadius.circular(10),
        hint: Text(
          selectedSubject.value != null
              ? selectedSubject.value!.japanese
              : "科目を選択",
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).greyText,
          ),
        ),
        onChanged: (selectedValue) {
          selectedSubject.value = selectedValue;
          setSubject(selectedValue);
        },
        items: Subject.values.map((Subject subject) {
          return DropdownMenuItem<Subject>(
            value: subject,
            child: Text(
              subject.japanese,
              style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: ColorSet.of(context).text,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
