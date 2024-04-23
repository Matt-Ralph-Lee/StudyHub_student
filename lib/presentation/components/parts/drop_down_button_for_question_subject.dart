import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/shared/subject.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class DropDownButtonForQuestionSubject extends HookWidget {
  final void Function(Subject?) setSubject;
  const DropDownButtonForQuestionSubject({
    super.key,
    required this.setSubject,
  });

  @override
  Widget build(BuildContext context) {
    final selectedSubject = useState<Subject?>(null);
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<Subject>(
          iconSize: FontSizeSet.getFontSize(
            context,
            FontSizeSet.header2,
          ),
          isExpanded: true,
          value: selectedSubject.value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: PaddingSet.getPaddingSize(context, 15),
              horizontal: PaddingSet.getPaddingSize(context, 5),
              //alignedDropdown: true,によりデフォでpadding入るため。DropdownButtonなりDropdownMenuなり試してみたけど、これが一番ちょうどいい
            ),
          ),
          dropdownColor: ColorSet.of(context).surface,
          borderRadius: BorderRadius.circular(10),
          hint: Text(
            selectedSubject.value != null
                ? selectedSubject.value!.japanese
                : L10n.selectSubject,
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
      ),
    );
  }
}
