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
import '../../../domain/student_auth/models/email_address.dart';
import '../../exceptions/student/student_infrastructure_exception.dart';
import '../../exceptions/student/student_infrastructure_exception_detail.dart';

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
      InMemoryStudentInitialValue.student3.studentId:
          InMemoryStudentInitialValue.student3,
    };
  }

  @override
  Future<void> delete(final StudentId studentId) async {
    store.remove(studentId);
  }

  @override
  Future<Student?> findById(final StudentId studentId) async {
    return store[studentId];
  }

  @override
  Future<void> create(final Student student) async {
    store[student.studentId] = student;
  }

  @override
  Future<void> update(final Student student) async {
    store[student.studentId] = student;
  }

  @override
  Future<void> incrementQuestionCount(StudentId studentId) async {
    final student = store[studentId];
    if (student == null) {
      throw const StudentInfrastructureException(
          StudentInfrastructureExceptionDetail.studentNotFound);
    }
    student.incrementQuestionCount();
    store[studentId] = student;
  }

  @override
  Future<bool> isStudent(final EmailAddress emailAddress) async {
    return store.values
        .map((student) => student.emailAddress)
        .contains(emailAddress);
  }

  @override
  Future<void> updateEmailAddress({
    required final StudentId studentId,
    required final EmailAddress newEmailAddress,
  }) async {
    final current = store[studentId];
    if (current == null) {
      throw const StudentInfrastructureException(
          StudentInfrastructureExceptionDetail.studentNotFound);
    }
    current.changeEmailAddress(newEmailAddress);
  }
}

class InMemoryStudentInitialValue {
  static final userStudentId = StudentId("000000000000000000000000010000");
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
    status: Status.beginner,
    emailAddress: EmailAddress('student1@example.com'),
  );

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
    status: Status.beginner,
    emailAddress: EmailAddress('student2@example.com'),
  );

  static final student3 = Student(
    studentId: StudentId('01234567890123456789'),
    name: Name('権兵衛'),
    profilePhotoPath:
        ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon2.jpg'),
    gender: Gender.male,
    occupation: Occupation.student,
    school: School('第三高校'),
    gradeOrGraduateStatus: GradeOrGraduateStatus.second,
    questionCount: QuestionCount(0),
    status: Status.beginner,
    emailAddress: EmailAddress('student3@example.com'),
  );
}
