import 'package:studyhub/application/student/exception/student_use_case_exception.dart';
import 'package:studyhub/application/student/exception/student_use_case_exception_detail.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/profile_image/i_profile_image_repository.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../shared/session/i_session.dart';

class StudentDeleteUseCase {
  final ISession _session;
  final IStudentAuthRepository _studentAuthRepository;
  final IStudentRepository _studentRepository;
  final IProfileImageRepository _profileImageRepository;
  StudentDeleteUseCase({
    required final ISession session,
    required final IStudentAuthRepository studentAuthRepository,
    required final IStudentRepository studentRepository,
    required final IProfileImageRepository profileImageRepository,
  })  : _session = session,
        _studentAuthRepository = studentAuthRepository,
        _studentRepository = studentRepository,
        _profileImageRepository = profileImageRepository;

  void execute() {
    final studentId = _session.studentId;
    final student = _studentRepository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    // TODO: delete all data.
    _studentRepository.delete(studentId);
    _profileImageRepository.delete(student.profileImagePath);
    _studentAuthRepository.delete(studentId);
  }
}
