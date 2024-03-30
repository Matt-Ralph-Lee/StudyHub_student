import '../../../domain/school/models/school.dart';
import '../../../domain/shared/name.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/question_count.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryStudentRepository implements IStudentRepository {
  late Map<StudentId, Student> store;
  static final InMemoryStudentRepository _instance =
      InMemoryStudentRepository._internal();

  factory InMemoryStudentRepository() {
    return _instance;
  }

  InMemoryStudentRepository._internal() {
    store = {
      InMemoryStudentInitialValue.student1.studentId:
          InMemoryStudentInitialValue.student1,
      InMemoryStudentInitialValue.student2.studentId:
          InMemoryStudentInitialValue.student2,
    };
  }

  @override
  void delete(final StudentId studentId) {
    store.remove(studentId);
  }

  @override
  Student? findById(final StudentId studentId) {
    return store[studentId];
  }

  @override
  void save(final Student student) {
    store[student.studentId] = student;
  }
}

class InMemoryStudentInitialValue {
  static final student1 = Student(
      studentId: StudentId('000000000000000000000000000001'),
      name: Name('太郎'),
      profilePhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon.jpg'),
      gender: Gender.male,
      occupation: Occupation.student,
      school: School('第一高校'),
      gradeOrGraduateStatus: GradeOrGraduateStatus.first,
      questionCount: QuestionCount(1),
      status: Status.beginner);

  static final student2 = Student(
      studentId: StudentId('000000000000000000000000000002'),
      name: Name('花子'),
      profilePhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon2.jpg'),
      gender: Gender.female,
      occupation: Occupation.student,
      school: School('第一高校'),
      gradeOrGraduateStatus: GradeOrGraduateStatus.second,
      questionCount: QuestionCount(1),
      status: Status.beginner);
}
