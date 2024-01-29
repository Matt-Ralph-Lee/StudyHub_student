import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/application/student/application_service/profile_update_command.dart';
import 'package:studyhub/application/student/application_service/profile_update_use_case.dart';
import 'package:studyhub/application/student/exception/student_use_case_exception.dart';
import 'package:studyhub/domain/school/models/school.dart';
import 'package:studyhub/domain/school/services/school_service.dart';
import 'package:studyhub/domain/shared/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/question_count.dart';
import 'package:studyhub/domain/student/models/status.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/shared/name.dart';
import 'package:studyhub/infrastructure/in_memory/school/in_memory_school_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';

void main() {
  final repository = InMemoryStudentRepository();
  final session = MockSession();
  final schoolRepository = InMemorySchoolRepository();
  final schoolService = SchoolService(schoolRepository);

  setUp(() {
    final studentId = StudentId('teststudent1234567890');
    final studentName = Name('nickname');
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.student;
    final school = School.noAnswer;
    const grade = Grade.other;
    final questionCount = QuestionCount(0);
    const status = Status.beginner;

    final student = Student(
      studentId: studentId,
      studentName: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      school: school,
      grade: grade,
      questionCount: questionCount,
      status: status,
    );
    repository.store[studentId] = student;
  });
  group('profile update use case', () {
    test('should update profile', () {
      final command = ProfileUpdateCommand(
        studentName: 'newname',
        gender: Gender.male,
        occupation: null,
        school: '第一高校',
        grade: null,
      );
      final usecase = ProfileUpdateUseCase(
        session: session,
        repository: repository,
        schoolService: schoolService,
      );
      usecase.execute(command);

      expect(repository.store[session.studentId]!.studentName, Name('newname'));
      expect(repository.store[session.studentId]!.gender, Gender.male);
      expect(
          repository.store[session.studentId]!.occupation, Occupation.student);
    });

    test('should throw error on invlaid school name', () {
      final command = ProfileUpdateCommand(
        studentName: null,
        gender: null,
        occupation: null,
        school: '第二高校',
        grade: null,
      );
      final usecase = ProfileUpdateUseCase(
        session: session,
        repository: repository,
        schoolService: schoolService,
      );
      expect(() => usecase.execute(command),
          throwsA(const TypeMatcher<StudentUseCaseException>()));
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
