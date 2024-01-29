import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/application/student/application_service/profile_photo_update_use_case.dart';
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
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryStudentRepository();
  final photoRepository = InMemoryPhotoRepository();

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

  group('profile photo update usecase', () {
    test('should update profile photo', () async {
      final usecase = ProfilePhotoUpdateUseCase(
        session: session,
        repository: repository,
        photoRepository: photoRepository,
      );

      const localPhotoPath = 'assets/images/sample_user_icon.jpg';

      await usecase.execute(localPhotoPath);

      final student = repository.findById(session.studentId);
      final currentPath = student!.profilePhotoPath;
      debugPrint(currentPath.value);

      expect(photoRepository.store[currentPath] != null, true);
      debugPrint(photoRepository.store[currentPath].toString());
    });

    test('should update profile photo which is not square', () async {
      final usecase = ProfilePhotoUpdateUseCase(
        session: session,
        repository: repository,
        photoRepository: photoRepository,
      );

      const localPhotoPath = 'assets/images/sample_user_icon2.jpg';

      // TODO: delay しないとうまくいかない
      await Future.delayed(const Duration(seconds: 2));

      await usecase.execute(localPhotoPath);

      final student = repository.findById(session.studentId);
      final currentPath = student!.profilePhotoPath;
      debugPrint(currentPath.value);

      debugPrint(photoRepository.store[currentPath].toString());
      expect(photoRepository.store[currentPath] != null, true);
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
