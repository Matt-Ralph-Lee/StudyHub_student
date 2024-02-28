import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/application/student/application_service/student_delete_use_case.dart';
import 'package:studyhub/domain/school/models/school.dart';
import 'package:studyhub/domain/shared/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/question_count.dart';
import 'package:studyhub/domain/student/models/status.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/shared/name.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';

void main() {
  final studentAuthRepository = InMemoryStudentAuthRepository();
  final studentRepository = InMemoryStudentRepository();
  final profilePhotoRepository = InMemoryPhotoRepository();

  setUp(() {
    final studentId = StudentId('teststudent1234567890');
    final emailAddress = EmailAddress('test@example.com');
    final password = Password('password123');
    final studentName = Name('nickname');
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.student;
    final school = School.noAnswer;
    const grade = Grade.other;
    final questionCount = QuestionCount(0);
    const status = Status.beginner;
    final studentAuthInfo = StudentAuthInfo(
      studentId: studentId,
      emailAddress: emailAddress,
      password: password,
      isVerified: true,
    );
    final student = Student(
      studentId: studentId,
      name: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      school: school,
      grade: grade,
      questionCount: questionCount,
      status: status,
    );
    studentAuthRepository.store[studentId] = studentAuthInfo;
    studentRepository.store[studentId] = student;
  });

  group('delete use case', () {
    test('should delete student', () {
      final session = MockSession();
      final usecase = StudentDeleteUseCase(
        session: session,
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
        photoRepository: profilePhotoRepository,
      );

      usecase.execute();

      expect(studentRepository.store[StudentId('teststudent1234567890')], null);
      expect(studentAuthRepository.store[StudentId('teststudent1234567890')],
          null);
      expect(
          studentAuthRepository.emailToIdMap[EmailAddress('test@example.com')],
          null);
      expect(
          studentAuthRepository
              .signedInStore[StudentId('teststudent1234567890')],
          null);
      expect(
          studentAuthRepository
              .streamControllers[StudentId('teststudent1234567890')],
          null);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
