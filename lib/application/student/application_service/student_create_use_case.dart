import 'package:english_words/english_words.dart';

import '../../../domain/school/models/school.dart';
import '../../../domain/shared/name.dart';
import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/question_count.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_factory.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/service/student_auth_domain_service.dart';
import '../../student_auth/exception/student_auth_use_case_exception.dart';
import '../../student_auth/exception/student_auth_use_case_exception_detail.dart';
import 'utils/photo_processing.dart';

class StudentCreateUseCase {
  final StudentAuthDomainService _service;
  final IStudentAuthRepository _repository;
  final IStudentAuthFactory _factory;
  final IStudentRepository _studentRepository;

  StudentCreateUseCase({
    required final StudentAuthDomainService service,
    required final IStudentAuthRepository repository,
    required final IStudentAuthFactory factory,
    required final IStudentRepository studentRepository,
  })  : _factory = factory,
        _repository = repository,
        _service = service,
        _studentRepository = studentRepository;

  Future<void> execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final studentAuthInfo = await _factory.createWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(studentAuthInfo)) {
      throw const StudentAuthUseCaseException(
          StudentAuthUseCaseExceptionDetail.alreadyExists);
    }
    _repository.create(studentAuthInfo);
    _service.requireVerification(studentAuthInfo);

    final student = _createInitially(studentAuthInfo.studentId);
    _studentRepository.save(student);
  }
}

Student _createInitially(StudentId studentId) {
  final studentName = Name(WordPair.random().asLowerCase);
  final profilePhotoPath = createPath('initial_photo');
  const gender = Gender.noAnswer;
  const occupation = Occupation.others;
  final school = School.noAnswer;
  const grade = Grade.other;
  final questionCount = QuestionCount(0);
  const status = Status.beginner;

  return Student(
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
}
