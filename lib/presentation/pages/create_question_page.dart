import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/question/exception/question_use_case_exception.dart';
import '../../application/question/exception/question_use_case_exception_detail.dart';
import '../../domain/question/models/question_photo_path_list.dart';
import '../../domain/question/models/selected_teacher_list.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/parts/elevated_button_for_create_question.dart';
import '../components/widgets/create_question_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../controllers/add_question_controller/add_question_contorller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//科目選択のドロップダウンの実装
class CreateQuestionPage extends ConsumerWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.1;
    final questionTitleController = useTextEditingController();
    final questionController = useTextEditingController();
    final picker = ImagePicker();
    final selectedPhotos = useState<List<String>>([]);
    final selectedTeachersId = useState<List<TeacherId>>([]);
    final isQuestionTitleFilled = useState<bool>(false);
    final isQuestionFilled = useState<bool>(false);

    final addQuestionControllerState = ref.watch(addQuestionControllerProvider);

    void checkQuestionTitleFilled(String text) {
      isQuestionTitleFilled.value = text.isNotEmpty;
    }

    void checkQuestionFilled(String text) {
      isQuestionFilled.value = text.isNotEmpty;
    }

    //デフォで直接枚数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void selectPhotos() async {
      const maxSelection = QuestionPhotoPathList.maxLength;
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        if (pickedFiles.length > maxSelection) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const SpecificExceptionModalWidget(
                  errorMessage: "写真は5枚まで❗");
            },
          );
        } else {
          final List<String> updatedList =
              List<String>.from(selectedPhotos.value ?? []);
          updatedList.addAll(pickedFiles.map((file) => file.path));
          selectedPhotos.value = updatedList;
        }
      }
    }

    void takePhoto() async {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final List<String> updatedList =
            List<String>.from(selectedPhotos.value ?? []);
        updatedList.add(pickedFile.path);
        selectedPhotos.value = updatedList;
      }
    }

    //デフォで直接数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void selectTeachers(List<TeacherId> teacherIds) async {
      const maxSelection = SelectedTeacherList.maxLength;
      if (teacherIds.length > maxSelection) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SpecificExceptionModalWidget(errorMessage: "講師は5人まで❗");
          },
        );
      } else {
        final List<TeacherId> updatedList =
            List<TeacherId>.from(selectedTeachersId.value ?? []);
        updatedList.addAll(teacherIds);
        selectedTeachersId.value = updatedList;
      }
    }

    void addQuestion() async {
      ref
          .read(addQuestionControllerProvider.notifier)
          .addQuestion(
            questionTitleController.text,
            questionController.text,
            null, //科目
            selectedPhotos.value,
            selectedTeachersId.value,
          )
          .then((_) {
        if (addQuestionControllerState is AsyncError) {
          final error = addQuestionControllerState.error;
          if (error is QuestionUseCaseException) {
            final errorText = L10n.getQuestionExceptionMessage(
                error.detail as QuestionUseCaseExceptionDetail);
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
            CompletionSnackBar(context, "質問しました！"),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: PaddingSet.getPaddingSize(context, 20)),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: topPadding),
                CreateQuestionWidget(
                  questionController: questionController,
                  questionTitleController: questionTitleController,
                  imageFilePath: selectedPhotos.value,
                  uploadPhotoFromCamera: () => selectPhotos(),
                  uploadPhotoFromGallery: () => takePhoto(),
                  checkQuestionFilledFunction: checkQuestionFilled,
                  checkQuestionTitleFilledFunction: checkQuestionTitleFilled,
                  selectTeachersFunction: selectTeachers,
                ),
                ElevatedButtonForCreateQuestion(
                  onPressed:
                      isQuestionTitleFilled.value && isQuestionFilled.value
                          ? () => addQuestion()
                          : null,
                )
              ],
            ),
            if (addQuestionControllerState.isLoading) const LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}
