import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/application/student/application_service/profile_update_command.dart';
import 'package:studyhub/application/student/application_service/profile_update_use_case.dart';
import 'package:studyhub/application/student/exception/student_use_case_exception.dart';
import 'package:studyhub/domain/school/models/school.dart';
import 'package:studyhub/domain/school/services/school_service.dart';
import 'package:studyhub/domain/shared/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade_or_graduate_status.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/question_count.dart';
import 'package:studyhub/domain/student/models/status.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/shared/name.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/school/in_memory_school_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() {
  final repository = InMemoryStudentRepository();
  final session = MockSession();
  final schoolRepository = InMemorySchoolRepository();
  final photoRepository = InMemoryPhotoRepository();
  final schoolService = SchoolService(schoolRepository);
  final logger = InMemoryLogger();

  setUp(() {
    final studentId = StudentId('teststudent1234567890');
    final studentName = Name('nickname');
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.student;
    final school = School.noAnswer;
    const gradeOrGraduateStatus = GradeOrGraduateStatus.other;
    final questionCount = QuestionCount(0);
    const status = Status.beginner;

    final student = Student(
      studentId: studentId,
      name: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      school: school,
      gradeOrGraduateStatus: gradeOrGraduateStatus,
      questionCount: questionCount,
      status: status,
      emailAddress: EmailAddress('teststudent@example.com'),
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
        gradeOrGraduateStatus: null,
        localPhotoPath: 'assets/photos/profile_photo/sample_user_icon.jpg',
      );
      final usecase = ProfileUpdateUseCase(
        session: session,
        repository: repository,
        schoolService: schoolService,
        photoRepository: photoRepository,
        logger: logger,
      );
      usecase.execute(command);

      expect(repository.store[session.studentId]!.name, Name('newname'));
      expect(repository.store[session.studentId]!.gender, Gender.male);
      expect(
          repository.store[session.studentId]!.occupation, Occupation.student);
    });

    test('should update profile photo with no-square photo', () async {
      final command = ProfileUpdateCommand(
        studentName: null,
        gender: null,
        occupation: null,
        school: null,
        gradeOrGraduateStatus: null,
        localPhotoPath: 'assets/photos/profile_photo/sample_user_icon2.jpg',
      );
      final usecase = ProfileUpdateUseCase(
        session: session,
        repository: repository,
        schoolService: schoolService,
        photoRepository: photoRepository,
        logger: logger,
      );
      usecase.execute(command);

      final student = await repository.findById(session.studentId);
      final currentPath = student!.profilePhotoPath;
      debugPrint(currentPath.value);

      final data = photoRepository.store[currentPath]!;
      final img = decodeJpg(data)!;

      debugPrint('height: ${img.height}, width: ${img.width}');
      expect(photoRepository.store[currentPath] != null, true);
    });

    test('should throw error on invalid school name', () {
      final command = ProfileUpdateCommand(
        studentName: null,
        gender: null,
        occupation: null,
        school: '第二高校',
        gradeOrGraduateStatus: null,
        localPhotoPath: null,
      );
      final usecase = ProfileUpdateUseCase(
        session: session,
        repository: repository,
        schoolService: schoolService,
        photoRepository: photoRepository,
        logger: logger,
      );
      expect(() => usecase.execute(command),
          throwsA(const TypeMatcher<StudentUseCaseException>()));
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');

  @override
  EmailAddress get emailAddress => EmailAddress("test@email.com");
}
