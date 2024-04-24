import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/student/application_service/profile_update_command.dart';
import '../../domain/student/models/gender.dart';
import '../../domain/student/models/grade_or_graduate_status.dart';
import '../../domain/student/models/occupation.dart';
import '../components/parts/progress_bar.dart';
import '../components/parts/text_for_profile_completion_welcome.dart';
import '../components/widgets/academic_history_input_widget.dart';
import '../components/widgets/gender_and_job_input_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../components/widgets/student_school_name_and_grade_input_widget.dart';
import '../components/widgets/user_name_input_widget.dart';
import '../controllers/profile_update_controller/profile_update_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/handle_error.dart';
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
      context.push(PageId.home.path);
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
        localPhotoPath: null,
      );

      ref
          .read(profileUpdateControllerProvider.notifier)
          .profileUpdate(profileUpdateCommand)
          .then((_) async {
        final currentState = ref.read(profileUpdateControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
          final errorMessage = handleError(context, error);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorModalWidget(
                errorMessage: errorMessage,
              );
            },
          );
          progress.value == 0;
        } else {
          Future.delayed(const Duration(seconds: 2)).then(
            (_) => push(context),
          );
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
      SizedBox(
        height: screenHeight * 0.5,
        child: const Center(
          child: TextForProfileCompletionWelcome(),
        ),
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
