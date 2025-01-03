import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/student/application_service/profile_update_command.dart';
import '../../domain/student/models/gender.dart';
import '../../domain/student/models/grade_or_graduate_status.dart';
import '../../domain/student/models/occupation.dart';
import '../components/parts/progress_bar.dart';
import '../components/widgets/academic_history_input_widget.dart';
import '../components/widgets/gender_and_job_input_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../components/widgets/student_school_name_and_grade_input_widget.dart';
import '../components/widgets/profile_image_and_user_name_input_widget.dart';
import '../components/widgets/welcome_confetti_widget.dart';
import '../controllers/profile_update_controller/profile_update_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/utils/handle_error.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class ProfileInputPage extends HookConsumerWidget {
  const ProfileInputPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.15;
    final progress = useState(0);
    final gender = useState<Gender?>(null);
    final job = useState<Occupation?>(null);
    final studentGrade = useState<GradeOrGraduateStatus?>(null);
    final othersGrade = useState<GradeOrGraduateStatus?>(null);
    final picker = ImagePicker();
    final profileImage = useState<String>("");
    final userNameInputController = useTextEditingController();
    final studentSchoolNameInputController = useTextEditingController();
    final academicHistoryInputController = useTextEditingController();

    void incrementProgressCounter() {
      HapticFeedback.lightImpact();
      progress.value++;
    }

    void decrementProgressCounter() {
      progress.value--;
    }

    void push(BuildContext context) {
      context.push(PageId.home.path);
    }

    void selectPhoto() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (!context.mounted) return;
      if (pickedFile != null) {
        profileImage.value = pickedFile.path;
      }
      context.pop();
    }

    void takePhoto() async {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (!context.mounted) return;
      if (pickedFile != null) {
        profileImage.value = pickedFile.path;
      }
      context.pop();
    }

    void updateProfile() async {
      incrementProgressCounter();

      final profileUpdateCommand = ProfileUpdateCommand(
        studentName: userNameInputController.text,
        gender: gender.value,
        occupation: job.value,
        school: job.value == Occupation.student
            ? studentSchoolNameInputController.text.isEmpty
                ? null
                : studentSchoolNameInputController.text
            : academicHistoryInputController.text.isEmpty
                ? null
                : academicHistoryInputController.text, //schoolドメインが定義されていない
        gradeOrGraduateStatus: job.value == Occupation.student
            ? studentGrade.value
            : othersGrade.value,
        localPhotoPath: profileImage.value,
      );

      await ref
          .read(profileUpdateControllerProvider.notifier)
          .profileUpdate(profileUpdateCommand);

      if (!context.mounted) return;

      final currentState = ref.read(profileUpdateControllerProvider);
      if (currentState.hasError) {
        final error = currentState.error;
        final errorMessage = handleError(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorModalWidget(
              errorMessage: errorMessage,
            );
          },
        );
        progress.value = 0;
      } else {
        await Future.delayed(const Duration(seconds: 5));
        if (!context.mounted) return;
        push(context);
      }
    }

    List<Widget> body = [
      ProfileImageAndUserNameInputWidget(
        userNameInputController: userNameInputController,
        incrementProgressCounter: incrementProgressCounter,
        profileImage: profileImage.value,
        uploadPhotoFromCamera: takePhoto,
        uploadPhotoFromGallery: selectPhoto,
      ),
      GenderAndJobInputWidget(
        genderValue: gender.value,
        jobValue: job.value,
        handleGenderChanged: (Gender? newValue) {
          gender.value = newValue;
        },
        handleJobChanged: (Occupation? newValue) {
          job.value = newValue;
        },
        incrementProgressCounter: incrementProgressCounter,
        decrementProgressCounter: decrementProgressCounter,
      ),
      (job.value == Occupation.student)
          ? StudentSchoolNameAndGradeInputWidget(
              decrementProgressCounter: decrementProgressCounter,
              updateProfile: updateProfile,
              studentSchoolNameInputController:
                  studentSchoolNameInputController,
              studentGradeValue: studentGrade.value,
              handleStudentGradeChanged: (GradeOrGraduateStatus? newValue) {
                studentGrade.value = newValue;
              },
            )
          : AcademicHistoryInputWidget(
              decrementProgressCounter: decrementProgressCounter,
              updateProfile: updateProfile,
              academicHistoryInputController: academicHistoryInputController,
              othersGradeValue: othersGrade.value,
              handleOthersGradeChanged: (GradeOrGraduateStatus? newValue) {
                othersGrade.value = newValue;
              },
            ),
      WelcomeConfettiWidget(
        decrementProgressCounter: decrementProgressCounter,
      ),
    ];

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: topPadding,
            horizontal: PaddingSet.getPaddingSize(
              context,
              PaddingSet.horizontalPadding,
            ),
          ),
          child: Column(
            children: [
              ProgressBar(
                  progress: (progress.value) * 0.35,
                  progressText: "${progress.value}/3"),
              const SizedBox(height: 50),
              //カルーセル調べるのめんどくさくてゴリ押しでこれ使ってみたけど一旦これでも耐えそう、、？
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Center(child: body[progress.value]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
