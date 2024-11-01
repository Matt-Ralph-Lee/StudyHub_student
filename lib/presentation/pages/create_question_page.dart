import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/question/models/question_photo_path_list.dart';
import '../../domain/question/models/question_text.dart';
import '../../domain/question/models/question_title.dart';
import '../../domain/question/models/selected_teacher_list.dart';
import '../../domain/shared/subject.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';

import '../components/parts/text_for_error.dart';
import '../components/widgets/add_images_or_select_teacher_widget.dart';
import '../components/widgets/add_question_main_content_widget.dart';
import '../components/widgets/confirm_question_modal.widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/question_pictures_for_confirm_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../components/widgets/teacher_profile_for_confirm_skeleton_widget.dart';
import '../components/widgets/teacher_profile_for_question_page_widget.dart';
import '../controllers/add_question_controller/add_question_controller.dart';
import '../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/utils/handle_error.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//科目選択のドロップダウンの実装
class CreateQuestionPage extends HookConsumerWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final questionTitleController = useTextEditingController();
    final questionController = useTextEditingController();
    final picker = ImagePicker();
    final selectedSubject = useState<Subject?>(null);
    final selectedPhotos = useState<List<String>>([]);
    final selectedTeachersId = useState<List<TeacherId>>([]);
    final questionTitleErrorText = useState<String?>(null);
    final questionErrorText = useState<String?>(null);
    final isQuestionTitleFilled = useState<bool>(false);
    final isQuestionFilled = useState<bool>(false);

    final addQuestionControllerState = ref.watch(addQuestionControllerProvider);

    void checkQuestionTitleFilled(String text) {
      if (text.length > QuestionTitle.maxLength) {
        questionTitleErrorText.value = L10n.questionTitleMaxLengthOverErrorText;
        isQuestionTitleFilled.value = false; //trueの状態でmaxLengthをoverする場合もあるので
      } else {
        questionTitleErrorText.value = null;
        isQuestionTitleFilled.value = text.isNotEmpty;
      }
    }

    void checkQuestionFilled(String text) {
      if (text.length > QuestionText.maxLength) {
        questionErrorText.value = L10n.questionMaxLengthOverErrorText;
        isQuestionFilled.value = false; //trueの状態でmaxLengthをoverする場合もあるので
      } else {
        questionErrorText.value = null;
        isQuestionFilled.value = text.isNotEmpty;
      }
    }

    void setSubject(Subject? subject) {
      selectedSubject.value = subject;
    }

    //デフォで直接枚数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void selectPhotos() async {
      const maxImages = QuestionPhotoPathList.maxLength;
      final List<String> updatedList = List<String>.from(selectedPhotos.value);
      final pickedFiles = await picker.pickMultiImage();
      if (!context.mounted) return;
      if (pickedFiles.isNotEmpty) {
        if (pickedFiles.length > maxImages ||
            updatedList.length + pickedFiles.length > maxImages) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorModalWidget(
                  errorMessage: L10n.maxImagesErrorText);
            },
          );
        } else {
          updatedList.addAll(pickedFiles.map((file) => file.path));
          selectedPhotos.value = updatedList;
          context.pop();
        }
      }
    }

    void takePhoto() async {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (!context.mounted) return;
      if (pickedFile != null) {
        const maxImages = QuestionPhotoPathList.maxLength;
        final List<String> updatedList =
            List<String>.from(selectedPhotos.value);

        if (updatedList.length >= maxImages) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorModalWidget(
                  errorMessage: L10n.maxImagesErrorText);
            },
          );
        } else {
          updatedList.add(pickedFile.path);
          selectedPhotos.value = updatedList;
          context.pop();
        }
      }
    }

    void deletePhoto(String imagePath) async {
      final List<String> updatedList = List<String>.from(selectedPhotos.value);

      updatedList.remove(imagePath);
      selectedPhotos.value = updatedList;
    }

    //デフォで直接数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void toggleTeacherSelection(TeacherId teacherId) async {
      final List<TeacherId> updatedList =
          List<TeacherId>.from(selectedTeachersId.value);

      if (updatedList.contains(teacherId)) {
        updatedList.remove(teacherId);
        selectedTeachersId.value = updatedList;
      } else {
        if (updatedList.length >= SelectedTeacherList.maxLength) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorModalWidget(
                errorMessage: L10n.maxTeachersErrorText,
              );
            },
          );
        } else {
          updatedList.add(teacherId);
          selectedTeachersId.value = updatedList;
        }
      }
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
        await ref.read(addQuestionControllerProvider.notifier).addQuestion(
              questionTitleController.text,
              questionController.text,
              selectedSubject.value!, //活性非活性のために既にボタンでnullチェックしているため
              selectedPhotos.value,
              selectedTeachersId.value,
            );
        if (!context.mounted) return;
        final addQuestionState = ref.read(addQuestionControllerProvider);
        if (addQuestionState.hasError) {
          final error = addQuestionState.error;
          final errorMessage = handleError(error);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorModalWidget(
                errorMessage: errorMessage,
              );
            },
          );
        } else {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.questionSnackBarText),
          );
          context.pop();
        }
      }
    }

    return Stack(children: [
      Scaffold(
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
                      color: ColorSet.of(context).text,
                    ),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 250,
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
                    disabledForegroundColor:
                        ColorSet.of(context).unselectedText),
                child: Text(
                  L10n.addQuestionButtonText,
                  style: TextStyle(
                    fontWeight: FontWeightSet.semibold,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: ColorSet.of(context).background,
        ),
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
            deletePhoto: deletePhoto,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: PaddingSet.getPaddingSize(
                  context,
                  PaddingSet.horizontalPadding,
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: PaddingSet.getPaddingSize(
                        context,
                        30,
                      ),
                    ),
                    AddQuestionMainContentWidget(
                      questionController: questionController,
                      questionTitleController: questionTitleController,
                      checkQuestionFilledFunction: checkQuestionFilled,
                      checkQuestionTitleFilledFunction:
                          checkQuestionTitleFilled,
                      selectSubjectFunction: setSubject,
                      questionErrorText: questionErrorText.value,
                      questionTitleErrorText: questionTitleErrorText.value,
                    ),
                    SizedBox(
                      height: PaddingSet.getPaddingSize(
                        context,
                        120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: screenWidth < 600 ? 150 : 225,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedPhotos.value.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              QuestionPictureForConfirmWidget(
                                            photoPath:
                                                selectedPhotos.value[index],
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                            onTap: () => deletePhoto(
                                                selectedPhotos.value[index]),
                                            child: Icon(
                                              Icons.cancel,
                                              color:
                                                  ColorSet.of(context).primary,
                                              size: FontSizeSet.getFontSize(
                                                context,
                                                FontSizeSet.header2,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: PaddingSet.getPaddingSize(
                        context,
                        30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: screenWidth < 600 ? 80 : 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedTeachersId.value.length,
                              itemBuilder: (context, index) {
                                final getTeacherProfileState = ref.watch(
                                    getTeacherProfileControllerProvider(
                                        selectedTeachersId.value[index]));

                                return getTeacherProfileState.when(
                                  data: (teacherProfileDto) =>
                                      teacherProfileDto != null
                                          ? Stack(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child:
                                                    TeacherProfileForQuestionPageWidget(
                                                  teacherProfileDto:
                                                      teacherProfileDto,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      toggleTeacherSelection(
                                                          selectedTeachersId
                                                              .value[index]),
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: ColorSet.of(context)
                                                        .primary,
                                                    size:
                                                        FontSizeSet.getFontSize(
                                                      context,
                                                      FontSizeSet.header2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ])
                                          : Text(
                                              L10n.noTeacherProfileFoundText,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeightSet.normal,
                                                  fontSize:
                                                      FontSizeSet.getFontSize(
                                                          context,
                                                          FontSizeSet.body),
                                                  color: ColorSet.of(context)
                                                      .text),
                                            ),
                                  loading: () => const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child:
                                        TeacherProfileWForConfirmSkeletonWidget(),
                                  ),
                                  error: (error, stack) => const Center(
                                      child: Column(
                                    children: [
                                      TextForError(),
                                    ],
                                  )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      if (addQuestionControllerState.isLoading) const LoadingOverlay(),
    ]);
  }
}
