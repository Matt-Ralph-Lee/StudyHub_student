import '../../school/models/school.dart';
import '../../shared/name.dart';
import '../../shared/subject.dart';
import '../models/bio.dart';
import '../models/graduated.dart';
import '../models/high_school.dart';
import '../models/introduction.dart';
import '../models/rating.dart';
import '../models/teacher_id.dart';
import '../models/university.dart';

class DefaultTeacher {
  static final teacherId = TeacherId("99999999999999999999");
  static final name = Name("teacher");
  static final highSchool = HighSchool(School.noAnswer.value);
  static final university = University(
      school: School.noAnswer.value,
      enrollmentStatus: EnrollmentStatus.graduated);
  static final bio = Bio("");
  static final introduction = Introduction("");
  static final rating = Rating(0);
  static final bestSubjects = <Subject>[];
  static const profilePhotoPath = "profile_photo/default/female_default.jpg";
}
