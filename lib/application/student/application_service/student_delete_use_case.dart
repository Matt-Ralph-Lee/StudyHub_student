import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../shared/session/session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';

class StudentDeleteUseCase {
  final Session _session;
  final IStudentAuthRepository _studentAuthRepository;
  final IStudentRepository _studentRepository;
  final IPhotoRepository _photoRepository;
  StudentDeleteUseCase({
    required final Session session,
    required final IStudentAuthRepository studentAuthRepository,
    required final IStudentRepository studentRepository,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _studentAuthRepository = studentAuthRepository,
        _studentRepository = studentRepository,
        _photoRepository = photoRepository;

// TODO: try-catch statement for all usecases
  Future<void> execute() async {
    final studentId = _session.studentId;
    final student = await _studentRepository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    _studentRepository.delete(studentId);
    _photoRepository.delete(student.profilePhotoPath);
    await _studentAuthRepository.delete();
  }
}
