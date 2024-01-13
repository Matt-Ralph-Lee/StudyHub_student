import 'package:studyhub/application/student/exception/student_use_case_exception.dart';
import 'package:studyhub/application/student/exception/student_use_case_exception_detail.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/profile_photo/i_profile_photo_repository.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../shared/session/i_session.dart';

class StudentDeleteUseCase {
  final ISession _session;
  final IStudentAuthRepository _studentAuthRepository;
  final IStudentRepository _studentRepository;
  final IProfilePhotoRepository _profilePhotoRepository;
  StudentDeleteUseCase({
    required final ISession session,
    required final IStudentAuthRepository studentAuthRepository,
    required final IStudentRepository studentRepository,
    required final IProfilePhotoRepository profilePhotoRepository,
  })  : _session = session,
        _studentAuthRepository = studentAuthRepository,
        _studentRepository = studentRepository,
        _profilePhotoRepository = profilePhotoRepository;

  void execute() {
    final studentId = _session.studentId;
    final student = _studentRepository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    _studentRepository.delete(studentId);
    _profilePhotoRepository.delete(student.profilePhotoPath);
    _studentAuthRepository.delete(studentId);
  }
}
