import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/student/models/occupation.dart';
import '../components/widgets/edit_profile_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picker = ImagePicker();
    final imageFilePath = useState<String?>(null);
    const defaultImage = "ユーザーの今のアイコンのパス";
    //()内側はユーザーの今の値
    final gender = useState<String?>("回答しない");
    final occupation = useState<String?>("学生");
    final studentGrade = useState<String?>("2年");
    final othersGrade = useState<String?>(null);
    final userNameInputController = useTextEditingController(text: "ユーザー名");
    final studentSchoolNameInputController =
        useTextEditingController(text: "学校名");
    final isUserNameFilled =
        useState<bool>(userNameInputController.text.isNotEmpty);
    final isSchoolNameFilled =
        useState<bool>(studentSchoolNameInputController.text.isNotEmpty);

    void checkUserNameFilled(String text) {
      isUserNameFilled.value = text.isNotEmpty;
    }

    void checkSchoolNameFilled(String text) {
      isSchoolNameFilled.value = text.isNotEmpty;
    }

    void handleGenderChanged(String? newValue) {
      gender.value = newValue;
    }

    void handleOccupationChanged(String? newValue) {
      occupation.value = newValue;
    }

    void handleStudentGradeChanged(String? newValue) {
      studentGrade.value = newValue;
    }

    void handleOthersGradeChanged(String? newValue) {
      othersGrade.value = newValue;
    }

    void takePhoto(ImageSource source) async {
      final pickedFile = await picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        imageFilePath.value = pickedFile.path;
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    L10n.cancelText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 130,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: isUserNameFilled.value &&
                        isSchoolNameFilled.value &&
                        ((occupation.value == Occupation.student.japanese &&
                                studentGrade.value != null) ||
                            (occupation.value != Occupation.student.japanese &&
                                othersGrade.value != null))
                    // ignore: avoid_print
                    ? () => print("活性なう")
                    : null,
                style: TextButton.styleFrom(
                    foregroundColor: ColorSet.of(context).primary,
                    disabledForegroundColor:
                        ColorSet.of(context).unselectedText),
                child: Text(
                  L10n.saveText,
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: ColorSet.of(context).background,
        ),
        backgroundColor: ColorSet.of(context).background,
        body: SingleChildScrollView(
            child: Column(
          children: [
            EditProfileWidget(
              userNameInputController: userNameInputController,
              studentSchoolNameInputController:
                  studentSchoolNameInputController,
              iconUrl: defaultImage,
              imageFilePath: imageFilePath.value,
              genderValue: gender.value,
              occupationValue: occupation.value,
              studentGradeValue: studentGrade.value,
              othersGradeValue: othersGrade.value,
              handleGenderChanged: handleGenderChanged,
              checkSchoolNameFilledFunction: checkSchoolNameFilled,
              checkUserNameFilledFunction: checkUserNameFilled,
              uploadPhotoFromCamera: () => takePhoto(ImageSource.camera),
              uploadPhotoFromGallery: () => takePhoto(ImageSource.gallery),
              handleOccupationChanged: handleOccupationChanged,
              handleStudentGradeChanged: handleStudentGradeChanged,
              handleOthersGradeChanged: handleOthersGradeChanged,
            ),
          ],
        )));
  }
}

//  void updateProfile() async {
//       incrementProgressCounter();

//       final Map<String, Gender> genderMap = {
//         for (var gender in Gender.values) gender.japanese: gender,
//       };
//       final Map<String, Occupation> occupationMap = {
//         for (var occupation in Occupation.values)
//           occupation.japanese: occupation,
//       };
//       final Map<String, GradeOrGraduateStatus> gradeMap = {
//         for (var grade in GradeOrGraduateStatus.values) grade.japanese: grade,
//       };
//       final Map<String, GradeOrGraduateStatus> graduateStatusMap = {
//         for (var graduateStatus in GradeOrGraduateStatus.values)
//           graduateStatus.japanese: graduateStatus,
//       };
//       final gradeForCommand = (job.value == '学生')
//           ? gradeMap[studentGrade.value]
//           : graduateStatusMap[othersGrade.value];

//       final schoolNameForCommand = (job.value == '学生')
//           ? studentSchoolNameInputController.text
//           : academicHistoryInputController.text;

//       final profileUpdateCommand = ProfileUpdateCommand(
//         studentName: userNameInputController.text,
//         gender: genderMap[gender.value],
//         occupation: occupationMap[job],
//         school: schoolNameForCommand, //schoolドメインが定義されていない
//         gradeOrGraduateStatus: gradeForCommand,
//         localPhotoPath: "assets/images/sample_user_icon.jpg",
//       );

//       ref
//           .read(profileUpdateControllerProvider.notifier)
//           .profileUpdate(profileUpdateCommand)
//           .then((_) {
//         final currentState = ref.read(profileUpdateControllerProvider);
//         if (currentState is AsyncError) {
//           final error = currentState.error;
//           if (error is StudentUseCaseException) {
//             final errorText = L10n.getStudentUseCaseExceptionMessage(
//                 error.detail as StudentUseCaseExceptionDetail);
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return SpecificExceptionModalWidget(
//                     errorMessage: errorText,
//                   );
//                 });
//           } else {
//             showErrorModalWidget(context);
//           }
//         } else {
//           push(context);
//         }
//       });
//     }