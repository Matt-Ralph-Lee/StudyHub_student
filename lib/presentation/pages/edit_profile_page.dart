import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getStudentState = ref.watch(studentControllerProvider);

    return getStudentState.when(
      data: (getStudentDto) {
        final picker = ImagePicker();
        final currentImagePath =
            useState<String>(getStudentDto.profilePhotoPath);
        final imageFilePath = useState<String?>(null);
        final gender = useState<Gender?>(getStudentDto.gender);
        final occupation = useState<Occupation?>(getStudentDto.occupation);
        final gradeOrGradeStatus = useState<GradeOrGraduateStatus?>(
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
          gradeOrGradeStatus.value = null;
          //null or occupationと対応する適当なgradeOrGradeStatusをデフォでセットしないとドロップダウンでエラーのなるため
          //後者よりはnullのほうが自然だと思ったので
        }

        void handleOthersGradeChanged(GradeOrGraduateStatus? newValue) {
          gradeOrGradeStatus.value = newValue;
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
            gradeOrGraduateStatus: gradeOrGradeStatus.value,
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
              context.go(PageId.myPage.path);
            }
          });
        }

        return Scaffold(
            appBar: AppBar(
              toolbarHeight: FontSizeSet.getFontSize(context, 50),
              leading: Padding(
                padding: EdgeInsets.only(
                  left: PaddingSet.getPaddingSize(
                    context,
                    PaddingSet.horizontalPadding,
                  ),
                ),
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
              leadingWidth: 250,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: PaddingSet.getPaddingSize(
                          context, PaddingSet.horizontalPadding)),
                  child: TextButton(
                    onPressed: isUserNameFilled.value
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
              padding: EdgeInsets.all(PaddingSet.getPaddingSize(
                context,
                PaddingSet.horizontalPadding,
              )),
              child: Column(
                children: [
                  EditProfileWidget(
                    userNameInputController: userNameInputController,
                    studentSchoolNameInputController:
                        studentSchoolNameInputController,
                    currentImagePath: currentImagePath.value,
                    imageFilePath: imageFilePath.value,
                    genderValue: gender.value,
                    occupationValue: occupation.value,
                    gradeOrGraduateStatusValue: gradeOrGradeStatus.value,
                    handleGenderChanged: handleGenderChanged,
                    checkUserNameFilledFunction: checkUserNameFilled,
                    uploadPhotoFromCamera: () => takePhoto(ImageSource.camera),
                    uploadPhotoFromGallery: () =>
                        takePhoto(ImageSource.gallery),
                    handleOccupationChanged: handleOccupationChanged,
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
