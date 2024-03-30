import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/question/exception/question_use_case_exception.dart';
import '../../application/question/exception/question_use_case_exception_detail.dart';
import '../../domain/question/models/question_photo_path_list.dart';
import '../../domain/shared/subject.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/widgets/add_images_or_select_teacher_widget.dart';
import '../components/widgets/add_question_main_content_widget.dart';
import '../components/widgets/confirm_question_modal.widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../controllers/add_question_controller/add_question_contorller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//科目選択のドロップダウンの実装
class CreateQuestionPage extends HookConsumerWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final questionTitleController = useTextEditingController();
    final questionController = useTextEditingController();
    final picker = ImagePicker();
    final selectedSubject = useState<Subject?>(null);
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

    void setSubject(Subject? subject) {
      selectedSubject.value = subject;
    }

    //デフォで直接枚数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void selectPhotos() async {
      const maxSelection = QuestionPhotoPathList.maxLength;
      picker.pickMultiImage().then((pickedFiles) {
        if (pickedFiles.isNotEmpty) {
          if (pickedFiles.length > maxSelection) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SpecificExceptionModalWidget(
                    errorMessage: L10n.maxImagesErrorText);
              },
            );
          } else {
            final List<String> updatedList =
                List<String>.from(selectedPhotos.value);
            updatedList.addAll(pickedFiles.map((file) => file.path));
            selectedPhotos.value = updatedList;
          }
        }
      });
    }

    void takePhoto() async {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final List<String> updatedList =
            List<String>.from(selectedPhotos.value);
        updatedList.add(pickedFile.path);
        selectedPhotos.value = updatedList;
      }
    }

    //デフォで直接数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void toggleTeacherSelection(TeacherId teacherId) async {
      final List<TeacherId> updatedList =
          List<TeacherId>.from(selectedTeachersId.value);

      if (updatedList.contains(teacherId)) {
        updatedList.remove(teacherId);
      } else {
        updatedList.add(teacherId);
      }
      selectedTeachersId.value = updatedList;
    }

    void addQuestion() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmQuestionModalWidget(
              questionTitle: questionTitleController.text,
              questionContent: questionController.text,
              subject: selectedSubject.value!,
              imagesPath: selectedPhotos.value,
              teacherId: selectedTeachersId.value,
            );
          });
      if (result) {
        ref
            .read(addQuestionControllerProvider.notifier)
            .addQuestion(
              questionTitleController.text,
              questionController.text,
              selectedSubject.value!, //活性非活性のために既にボタンでnullチェックしているため
              selectedPhotos.value,
              selectedTeachersId.value,
            )
            .then((_) {
          if (addQuestionControllerState.hasError) {
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
              context.pop();
            } else {
              showErrorModalWidget(context);
              context.pop();
            }
          } else {
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              completionSnackBar(context, L10n.questionSnackBarText),
            );
            context.pop();
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: FontSizeSet.getFontSize(context, 50),
        shape: Border(
            bottom: BorderSide(
          width: 0.1,
          color: ColorSet.of(context).text,
        )),
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
              onPressed: isQuestionTitleFilled.value &&
                      isQuestionFilled.value &&
                      selectedSubject.value != null
                  ? () => addQuestion()
                  : null,
              style: TextButton.styleFrom(
                  foregroundColor: ColorSet.of(context).primary,
                  disabledForegroundColor: ColorSet.of(context).unselectedText),
              child: Text(
                L10n.addQuestionButtonText,
                style: TextStyle(
                  fontWeight: FontWeightSet.semibold,
                  fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: ColorSet.of(context).background,
      ),
      //キーボード出したときに下のsafeArea?的なのが出てくるの抑えたい
      bottomNavigationBar: BottomAppBar(
        color: ColorSet.of(context).background,
        padding: const EdgeInsets.only(top: 0),
        child: AddImagesOrSelectTeachersWidget(
          imageFilePath: selectedPhotos.value,
          uploadPhotoFromCamera: takePhoto,
          uploadPhotoFromGallery: selectPhotos,
          selectTeachersFunction: toggleTeacherSelection,
          teacherIds: selectedTeachersId,
          isTeacherSelected: selectedTeachersId.value.isNotEmpty,
          isPhotoAdded: selectedPhotos.value.isNotEmpty,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: PaddingSet.getPaddingSize(context, 20)),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  AddQuestionMainContentWidget(
                    questionController: questionController,
                    questionTitleController: questionTitleController,
                    checkQuestionFilledFunction: checkQuestionFilled,
                    checkQuestionTitleFilledFunction: checkQuestionTitleFilled,
                    selectSubjectFunction: setSubject,
                  ),
                ],
              ),
            ),
            if (addQuestionControllerState.isLoading) const LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}
