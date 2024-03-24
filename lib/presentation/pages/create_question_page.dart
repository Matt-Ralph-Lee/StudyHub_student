import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/question/models/question_photo_path_list.dart';
import '../../domain/question/models/selected_teacher_list.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/widgets/create_question_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/padding_set.dart';

//科目選択のドロップダウンの実装
//questionControllerを叩く&whenでuiの切り替え

class CreateQuestionPage extends StatelessWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.1;
    final questionTitleController = useTextEditingController();
    final questionController = useTextEditingController();
    final picker = ImagePicker();
    final selectedPhotos = useState<List<String>?>([]);
    final selectedTeachersId = useState<List<TeacherId>>([]);
    final isQuestionTitleFilled = useState<bool>(false);
    final isQuestionFilled = useState<bool>(false);

    void checkQuestionTitleFilled(String text) {
      isQuestionTitleFilled.value = text.isNotEmpty;
    }

    void checkQuestionFilled(String text) {
      isQuestionFilled.value = text.isNotEmpty;
    }

    //デフォで直接枚数制限はできないぽいので、予め注意&選択後にチェックの二刀流で
    void selectPhotos() async {
      final maxSelection = QuestionPhotoPathList.maxLength;
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
      final maxSelection = SelectedTeacherList.maxLength;
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

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: PaddingSet.getPaddingSize(context, 20)),
        child: Column(
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
            ElevatedButtonForCreateQuestion(onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
