import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/application/student/application_service/student_delete_use_case.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/school_name.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student/models/student_name.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() {
  setUp(() => null);
  group('delete use case', () {
    final studentAuthRepository = InMemoryStudentAuthRepository();
    final studentRepository = InMemoryStudentRepository();
    final profilePhotoRepository = InMemoryPhotoRepository();

    final studentId = StudentId('teststudent1234567890');
    final emailAddress = EmailAddress('test@example.com');
    final password = Password('password123');
    final studentName = StudentName('nickname');
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.student;
    final schoolName = SchoolName('noAnswer');
    const grade = Grade.other;
    final studentAuthInfo = StudentAuthInfo(
      studentId: studentId,
      emailAddress: emailAddress,
      password: password,
      isVerified: true,
    );
    final student = Student(
      studentId: studentId,
      studentName: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      schoolName: schoolName,
      grade: grade,
    );
    studentAuthRepository.store[studentId] = studentAuthInfo;
    studentRepository.store[studentId] = student;

    test('should delete student', () {
      final session = MockSession();
      final usecase = StudentDeleteUseCase(
        session: session,
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
        photoRepository: profilePhotoRepository,
      );

      usecase.execute();

      expect(studentRepository.store[studentId], null);
      expect(studentAuthRepository.store[studentId], null);
      expect(studentAuthRepository.emailToIdMap[emailAddress], null);
      expect(studentAuthRepository.signedInStore[studentId], null);
      expect(studentAuthRepository.streamControllers[studentId], null);
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
