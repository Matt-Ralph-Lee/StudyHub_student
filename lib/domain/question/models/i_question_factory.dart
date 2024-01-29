import "../../shared/subject.dart";
import "question.dart";
import "question_title.dart";
import "question_text.dart";
import "question_photo_path_list.dart";
import "selected_teacher_list.dart";

import "../../student/models/student_id.dart";

abstract class IQuestionFactory {
  // id生成がfirestoreに依存するためFutureである
  Future<Question> createQuestion(
      Subject questionSubject,
      StudentId studentId,
      QuestionTitle questionTitle,
      QuestionText questionText,
      QuestionPhotoPathList questionPhotoPathList,
      SelectedTeacherList selectedTeacherList);
}
