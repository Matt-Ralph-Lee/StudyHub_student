import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/student/application_service/profile_update_command.dart';
import '../../application/student/exception/student_use_case_exception.dart';
import '../../application/student/exception/student_use_case_exception_detail.dart';
import '../../domain/student/models/gender.dart';
import '../../domain/student/models/grade_or_graduate_status.dart';
import '../../domain/student/models/occupation.dart';
import '../components/parts/progress_bar.dart';
import '../components/parts/text_for_profile_completion_welcome.dart';
import '../components/widgets/academic_history_input_widget.dart';
import '../components/widgets/gender_and_job_input_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/student_school_name_and_grade_input_widget.dart';
import '../components/widgets/user_name_input_widget.dart';
import '../controllers/profile_update_controller/profile_update_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';

class ProfileInputPage extends HookConsumerWidget {
  const ProfileInputPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = screenHeight * 0.15;
    final horizontalPadding = screenWidth * 0.1;
    final progress = useState(0);
    final gender = useState<Gender?>(null);
    final job = useState<Occupation?>(null);
    final studentGrade = useState<GradeOrGraduateStatus?>(null);
    final othersGrade = useState<GradeOrGraduateStatus?>(null);
    final userNameInputController = useTextEditingController();
    final studentSchoolNameInputController = useTextEditingController();
    final academicHistoryInputController = useTextEditingController();

    void incrementProgressCounter() {
      progress.value++;
    }

    void decrementProgressCounter() {
      progress.value--;
    }

    void push(BuildContext context) {
      context.push(PageId.searchQuestions.path);
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
        localPhotoPath: "assets/photos/profile_photo/sample_user_icon.jpg",
      );
      print("コマンド作った");

      ref
          .read(profileUpdateControllerProvider.notifier)
          .profileUpdate(profileUpdateCommand)
          .then((_) {
        final currentState = ref.read(profileUpdateControllerProvider);
        print("state読んだ");
        if (currentState.hasError) {
          final error = currentState.error;
          print("erroとったよ");
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
          print("pushするよ");
          push(context);
        }
      });
    }

    List<Widget> body = [
      UserNameInputWidget(
        userNameInputController: userNameInputController,
        incrementProgressCounter: incrementProgressCounter,
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
      const TextForProfileCompletionWelcome(),
    ];

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: topPadding, horizontal: horizontalPadding),
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
                child: body[progress.value],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
