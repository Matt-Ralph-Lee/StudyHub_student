import 'package:english_words/english_words.dart';

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
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../interfaces/i_logger.dart';

class StudentCreateUseCase {
  final IStudentAuthRepository _studentAuthRepository;
  final IStudentRepository _studentRepository;
  final ILogger _logger;

  StudentCreateUseCase({
    required final IStudentAuthRepository studentAuthRepository,
    required final IStudentRepository studentRepository,
    required final ILogger logger,
  })  : _studentAuthRepository = studentAuthRepository,
        _studentRepository = studentRepository,
        _logger = logger;

  Future<void> execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    _logger.info('BEGIN $StudentCreateUseCase.execute()');

    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);

    await _studentAuthRepository.createWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );

    await _studentAuthRepository.sendEmailVerification();

    final student =
        _createInitially(_studentAuthRepository.getStudentIdSnapshot()!);

    await _studentRepository.create(student);

    _logger.info('END $StudentCreateUseCase.execute()');
  }
}

Student _createInitially(final StudentId studentId) {
  final studentName = Name(WordPair.random().asLowerCase);
  // final profilePhotoPath = createPath('initial_photo');
  final profilePhotoPath =
      ProfilePhotoPath("profile_photo/default/male_default.jpg");
  const gender = Gender.noAnswer;
  const occupation = Occupation.others;
  final school = School.noAnswer;
  const gradeOrGraduateStatus = GradeOrGraduateStatus.other;
  final questionCount = QuestionCount(0);
  const status = Status.beginner;

  return Student(
    studentId: studentId,
    name: studentName,
    profilePhotoPath: profilePhotoPath,
    gender: gender,
    occupation: occupation,
    school: school,
    gradeOrGraduateStatus: gradeOrGraduateStatus,
    questionCount: questionCount,
    status: status,
  );
}
