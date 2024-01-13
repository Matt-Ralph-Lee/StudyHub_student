import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/application/student/application_service/profile_update_command.dart';
import 'package:studyhub/application/student/application_service/profile_update_use_case.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/school_name.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student/models/student_name.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';

void main() {
  setUp(() => null);
  group('profile update use case', () {
    final repository = InMemoryStudentRepository();
    final session = MockSession();

    final studentId = StudentId('teststudent1234567890');
    final studentName = StudentName('nickname');
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.student;
    final schoolName = SchoolName('noAnswer');
    const grade = Grade.other;

    final student = Student(
      studentId: studentId,
      studentName: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      schoolName: schoolName,
      grade: grade,
    );
    repository.store[studentId] = student;
    test('should update profile', () {
      final command = ProfileUpdateCommand(
        studentName: 'newname',
        gender: Gender.male,
        occupation: null,
        schoolName: null,
        grade: null,
      );
      final usecase =
          ProfileUpdateUseCase(session: session, repository: repository);
      usecase.execute(command);

      expect(repository.store[studentId]!.studentName, StudentName('newname'));
      expect(repository.store[studentId]!.gender, Gender.male);
      expect(repository.store[studentId]!.occupation, occupation);
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
