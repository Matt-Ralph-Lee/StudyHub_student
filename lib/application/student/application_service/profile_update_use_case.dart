import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/school_name.dart';
import '../../../domain/student/models/student_name.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'profile_update_command.dart';

class ProfileUpdateUseCase {
  final ISession _session;
  final IStudentRepository _repository;

  ProfileUpdateUseCase({
    required ISession session,
    required IStudentRepository repository,
  })  : _session = session,
        _repository = repository;

  void execute(ProfileUpdateCommand command) {
    final studentId = _session.studentId;
    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }

    final newStudentNameData = command.studentName;
    final newGender = command.gender;
    final newOccupation = command.occupation;
    final newSchoolNameData = command.schoolName;
    final newGrade = command.grade;

    if (newStudentNameData != null) {
      student.changeStudentName(StudentName(newStudentNameData));
    }

    if (newGender != null) {
      student.changeGender(newGender);
    }

    if (newOccupation != null) {
      student.changeOccupation(newOccupation);
    }

    if (newSchoolNameData != null) {
      student.changeSchoolName(SchoolName(newSchoolNameData));
    }

    if (newGrade != null) {
      student.changeGrade(newGrade);
    }

    _repository.save(student);
  }
}
