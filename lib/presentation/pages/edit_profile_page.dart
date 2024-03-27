import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studyhub/presentation/controllers/get_my_profile_controller/get_my_profile_controller.dart';
import 'package:studyhub/presentation/shared/constants/page_path.dart';

import '../../application/student/application_service/profile_update_command.dart';
import '../../application/student/exception/student_use_case_exception.dart';
import '../../application/student/exception/student_use_case_exception_detail.dart';
import '../../domain/student/models/gender.dart';
import '../../domain/student/models/grade_or_graduate_status.dart';
import '../../domain/student/models/occupation.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/widgets/edit_profile_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../controllers/profile_update_controller/profile_update_controller.dart';
import '../controllers/student_controller/student_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getStudentState = ref.watch(studentControllerProvider);

    return getStudentState.when(
      data: (getStudentDto) {
        final picker = ImagePicker();
        final imageFilePath = useState<String?>(null);
        final defaultImage = getStudentDto.profilePhotoPath;
        final gender = useState<Gender?>(getStudentDto.gender);
        final occupation = useState<Occupation?>(getStudentDto.occupation);
        final studentGrade = useState<GradeOrGraduateStatus?>(
            getStudentDto.gradeOrGraduateStatus);
        final othersGrade = useState<GradeOrGraduateStatus?>(
            getStudentDto.gradeOrGraduateStatus);
        final userNameInputController =
            useTextEditingController(text: getStudentDto.studentName);
        final studentSchoolNameInputController =
            useTextEditingController(text: getStudentDto.school);
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

        void handleGenderChanged(Gender? newValue) {
          gender.value = newValue;
        }

        void handleOccupationChanged(Occupation? newValue) {
          occupation.value = newValue;
        }

        void handleStudentGradeChanged(GradeOrGraduateStatus? newValue) {
          studentGrade.value = newValue;
        }

        void handleOthersGradeChanged(GradeOrGraduateStatus? newValue) {
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

        void updateProfile() {
          final profileUpdateCommand = ProfileUpdateCommand(
            studentName: userNameInputController.text,
            gender: gender.value,
            occupation: occupation.value,
            school: studentSchoolNameInputController.text,
            gradeOrGraduateStatus: occupation.value == Occupation.student
                ? studentGrade.value
                : othersGrade.value,
            localPhotoPath: imageFilePath.value,
          );

          ref
              .read(profileUpdateControllerProvider.notifier)
              .profileUpdate(profileUpdateCommand)
              .then((_) {
            final currentState = ref.read(profileUpdateControllerProvider);
            if (currentState.hasError) {
              final error = currentState.error;
              if (error is StudentUseCaseException) {
                final errorText = L10n.getStudentUseCaseExceptionMessage(
                    error.detail as StudentUseCaseExceptionDetail);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SpecificExceptionModalWidget(
                        errorMessage: errorText,
                      );
                    });
              } else {
                showErrorModalWidget(context);
              }
            } else {
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                completionSnackBar(context, L10n.editSuccessText),
              );
              ref.invalidate(getMyProfileControllerProvider);
              context.go(PageId.myPage.path);
            }
          });
        }

        return Scaffold(
            appBar: AppBar(
              toolbarHeight: FontSizeSet.getFontSize(context, 50),
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
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
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
                            ((occupation.value == Occupation.student &&
                                    studentGrade.value != null) ||
                                (occupation.value != Occupation.student &&
                                    othersGrade.value != null))
                        ? () {
                            updateProfile();
                          }
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
                child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                    uploadPhotoFromGallery: () =>
                        takePhoto(ImageSource.gallery),
                    handleOccupationChanged: handleOccupationChanged,
                    handleStudentGradeChanged: handleStudentGradeChanged,
                    handleOthersGradeChanged: handleOthersGradeChanged,
                  ),
                ],
              ),
            )));
      },
      loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator())), // ローディング表示
      error: (error, _) =>
          const Scaffold(body: Center(child: Text('エラーが発生しました'))), // エラー表示
    );
  }
}
