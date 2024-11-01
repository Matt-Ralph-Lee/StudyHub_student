import 'package:flutter/material.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/button_for_adding_picture.dart';
import '../parts/button_for_selecting_teachers.dart';

class AddImagesOrSelectTeachersWidget extends StatelessWidget {
  final List<String>? imageFilePath;
  final ValueNotifier<List<TeacherId>> teacherIds;
  final bool isTeacherSelected;
  final bool isPhotoAdded;
  final void Function() uploadPhotoFromCamera;
  final void Function() uploadPhotoFromGallery;
  final void Function(String)? deletePhoto;
  final void Function(TeacherId) selectTeachersFunction;
  const AddImagesOrSelectTeachersWidget({
    super.key,
    required this.imageFilePath,
    required this.teacherIds,
    required this.isTeacherSelected,
    required this.isPhotoAdded,
    required this.uploadPhotoFromCamera,
    required this.uploadPhotoFromGallery,
    required this.deletePhoto,
    required this.selectTeachersFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: ColorSet.of(context).background,
            border: Border(
                top: BorderSide(
              width: 0.1,
              color: ColorSet.of(context).text,
            ))),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonForAddingPicture(
                takePhoto: uploadPhotoFromCamera,
                pickPhoto: uploadPhotoFromGallery,
                isPicturesAdded: isPhotoAdded,
              ),
              SizedBox(
                height: PaddingSet.getPaddingSize(
                  context,
                  20,
                ),
              ),
              ButtonForSelectingTeacher(
                selectTeachersFunction: selectTeachersFunction,
                selectedTeachers: teacherIds,
                isTeacherSelected: isTeacherSelected,
              ),
            ],
          ),
        ));
  }
}
