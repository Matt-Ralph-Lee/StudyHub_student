import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/parts/progress_bar.dart';
import '../components/parts/text_for_profile_completion_welcome.dart';
import '../components/widgets/academic_history_input_widget.dart';
import '../components/widgets/gender_and_job_input_widget.dart';
import '../components/widgets/student_school_name_and_grade_input_widget.dart';
import '../components/widgets/user_name_input_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/l10n.dart';

class ProfileInputPage extends HookWidget {
  const ProfileInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = screenHeight * 0.15;
    final horizontalPadding = screenWidth * 0.1;
    final progress = useState(0);
    final gender = useState<String?>(null);
    final job = useState<String?>(null);
    final studentGrade = useState<String?>(null);
    final othersGrade = useState<String?>(null);
    final userNameInputController = useTextEditingController();
    final studentSchoolNameInputController = useTextEditingController();
    final academicHistoryInputController = useTextEditingController();

    void incrementProgressCounter() {
      progress.value++;
    }

    void decrementProgressCounter() {
      progress.value--;
    }

    List<Widget> body = [
      UserNameInputWidget(
        userNameInputController: userNameInputController,
        incrementProgressCounter: incrementProgressCounter,
      ),
      GenderAndJobInputWidget(
        genderValue: gender.value,
        jobValue: job.value,
        handleGenderChanged: (String? newValue) {
          gender.value = newValue;
        },
        handleJobChanged: (String? newValue) {
          job.value = newValue;
        },
        incrementProgressCounter: incrementProgressCounter,
        decrementProgressCounter: decrementProgressCounter,
      ),
      (job.value == L10n.jobOptionStudent)
          ? StudentSchoolNameAndGradeInputWidget(
              incrementProgressCounter: incrementProgressCounter,
              decrementProgressCounter: decrementProgressCounter,
              studentSchoolNameInputController:
                  studentSchoolNameInputController,
              studentGradeValue: studentGrade.value,
              handleStudentGradeChanged: (String? newValue) {
                studentGrade.value = newValue;
              },
            )
          : AcademicHistoryInputWidget(
              incrementProgressCounter: incrementProgressCounter,
              decrementProgressCounter: decrementProgressCounter,
              academicHistoryInputController: academicHistoryInputController,
              othersGradeValue: othersGrade.value,
              handleOthersGradeChanged: (String? newValue) {
                othersGrade.value = newValue;
              },
            ),
      const TextForProfileCompletionWelcome(),
    ];

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: topPadding),
              ProgressBar(
                  progress: (progress.value) * 0.35,
                  progressText: "${progress.value}/3"),
              const SizedBox(height: 50),
              //カルーセル調べるのめんどくさくてゴリ押しでこれ使ってみたけど一旦これでも耐えそう、、？
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
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
