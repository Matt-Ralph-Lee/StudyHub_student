import '../../school/models/school.dart';
import '../../shared/name.dart';
import '../../shared/profile_photo_path.dart';
import '../models/gender.dart';
import '../models/grade_or_graduate_status.dart';
import '../models/occupation.dart';
import '../models/question_count.dart';
import '../models/status.dart';
import '../models/student_id.dart';

class DefaultStudent {
  static final studentId = StudentId("99999999999999999999");
  static final name = Name("student");
  static final profilePhoto =
      ProfilePhotoPath("profile_photo/default/male_default.jpg");
  static const gender = Gender.noAnswer;
  static const occupation = Occupation.others;
  static final school = School.noAnswer;
  static const gradeOrGraduateStatus = GradeOrGraduateStatus.other;
  static final questionCount = QuestionCount(0);
  static const status = Status.beginner;
}
