import '../../../domain/school/models/school.dart';
import '../../../domain/school/services/school_service.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/shared/name.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'profile_update_command.dart';

class ProfileUpdateUseCase {
  final ISession _session;
  final IStudentRepository _repository;
  final SchoolService _schoolService;

  ProfileUpdateUseCase(
      {required final ISession session,
      required final IStudentRepository repository,
      required final SchoolService schoolService})
      : _session = session,
        _repository = repository,
        _schoolService = schoolService;

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
    final newSchoolData = command.school;
    final newGrade = command.grade;

    if (newStudentNameData != null) {
      student.changeStudentName(Name(newStudentNameData));
    }

    if (newGender != null) {
      student.changeGender(newGender);
    }

    if (newOccupation != null) {
      student.changeOccupation(newOccupation);
    }

    if (newSchoolData != null) {
      final newSchool = School(newSchoolData);

      if (newSchool != School.noAnswer &&
          !_schoolService.exists(school: newSchool, schoolType: null)) {
        throw const StudentUseCaseException(
            StudentUseCaseExceptionDetail.noSuchSchool);
      }

      student.changeSchool(School(newSchoolData));
    }

    if (newGrade != null) {
      student.changeGrade(newGrade);
    }

    _repository.save(student);
  }
}
