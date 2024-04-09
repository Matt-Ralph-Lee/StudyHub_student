import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:studyhub/domain/student/models/gender.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class DropDownButtonForGenderInput extends HookWidget {
  final Gender? groupValue;
  final ValueChanged<Gender?> onChanged;

  DropDownButtonForGenderInput({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final genderOptions = Gender.values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                L10n.genderRadioBoxLabelText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                        context, FontSizeSet.annotation),
                    color: ColorSet.of(context).greyText),
              )
            ],
          ),
          const SizedBox(height: 10),
          ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<Gender>(
              iconSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header2,
              ),
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fillColor: ColorSet.of(context).greySurface,
                contentPadding: EdgeInsets.symmetric(
                  vertical: PaddingSet.getPaddingSize(context, 15),
                  horizontal: PaddingSet.getPaddingSize(context,
                      5), //alignedDropdown: true,によりデフォでpadding入るため。DropdownButtonなりDropdownMenuなり試してみたけど、これが一番ちょうどいい
                ),
              ),
              value: groupValue,
              isDense: true,
              dropdownColor: ColorSet.of(context).greySurface,
              onChanged: onChanged,
              items: genderOptions.map((Gender value) {
                return DropdownMenuItem<Gender>(
                  value: value,
                  child: Text(
                    value.japanese,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        ),
                        color: ColorSet.of(context).text),
                  ),
                );
              }).toList(),
            ),
          ),
          // InputDecorator(
          //   decoration: InputDecoration(
          //     filled: true,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     fillColor: ColorSet.of(context).greySurface,
          //     contentPadding: EdgeInsets.symmetric(
          //       // vertical: PaddingSet.getPaddingSize(context, 15),
          //       horizontal: PaddingSet.getPaddingSize(context, 20),
          //     ),
          //   ),
          //   child: ButtonTheme(
          //     // alignedDropdown: true,
          //     child: DropdownButtonHideUnderline(
          //       child: DropdownButton<Gender>(
          //         isExpanded: false,
          //         value: groupValue,
          //         dropdownColor: ColorSet.of(context).greySurface,
          //         onChanged: onChanged,
          //         items: genderOptions.map((Gender value) {
          //           return DropdownMenuItem<Gender>(
          //             value: value,
          //             child: Text(
          //               value.japanese,
          //               style: TextStyle(
          //                   height: 2,
          //                   fontWeight: FontWeightSet.normal,
          //                   fontSize: FontSizeSet.getFontSize(
          //                       context, FontSizeSet.annotation),
          //                   color: ColorSet.of(context).text),
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //   ),
          // ),
          // DropdownMenu<Gender>(
          //   menuStyle: MenuStyle(
          //     backgroundColor:
          //         MaterialStatePropertyAll(ColorSet.of(context).greySurface),
          //   ),
          //   width: screenWidth - 40,
          //   textStyle: TextStyle(
          //     fontWeight: FontWeightSet.normal,
          //     fontSize:
          //         FontSizeSet.getFontSize(context, FontSizeSet.annotation),
          //     color: ColorSet.of(context).whiteText,
          //   ),
          //   inputDecorationTheme: InputDecorationTheme(
          //     contentPadding: const EdgeInsets.only(
          //       left: 20,
          //     ),
          //     filled: true,
          //     fillColor: ColorSet.of(context).greySurface,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(5.0),
          //       borderSide: BorderSide.none,
          //     ),
          //   ),
          //   onSelected: onChanged,
          //   dropdownMenuEntries: genderOptions.map((Gender value) {
          //     return DropdownMenuEntry<Gender>(
          //         value: value,
          //         label: value.japanese,
          //         style: ButtonStyle(
          //             foregroundColor:
          //                 MaterialStatePropertyAll(ColorSet.of(context).text),
          //             textStyle: MaterialStatePropertyAll(TextStyle(
          //               height: 2,
          //               fontWeight: FontWeightSet.normal,
          //               fontSize: FontSizeSet.getFontSize(
          //                   context, FontSizeSet.annotation),
          //             ))));
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
