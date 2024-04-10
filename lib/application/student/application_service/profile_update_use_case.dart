import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/school/models/school.dart';
import '../../../domain/school/services/school_service.dart';
import '../../../domain/shared/profile_photo.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/shared/name.dart';
import '../../shared/session/session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'profile_update_command.dart';
import 'utils/photo_processing.dart';

class ProfileUpdateUseCase {
  final Session _session;
  final IStudentRepository _repository;
  final SchoolService _schoolService;
  final IPhotoRepository _photoRepository;

  ProfileUpdateUseCase({
    required final Session session,
    required final IStudentRepository repository,
    required final SchoolService schoolService,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _schoolService = schoolService,
        _photoRepository = photoRepository;

  Future<void> execute(ProfileUpdateCommand command) async {
    final studentId = _session.studentId;
    final student = await _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }

    final newStudentNameData = command.studentName;
    final newGender = command.gender;
    final newOccupation = command.occupation;
    final newSchoolData = command.school;
    final newGradeOrGraduateStatus = command.gradeOrGraduateStatus;
    final newLocalPhotoPath = command.localPhotoPath;

    if (newStudentNameData != null) {
      student.changeName(Name(newStudentNameData));
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
          !await _schoolService.exists(school: newSchool, schoolType: null)) {
        throw const StudentUseCaseException(
            StudentUseCaseExceptionDetail.noSchoolFound);
      }

      student.changeSchool(School(newSchoolData));
    }

    if (newGradeOrGraduateStatus != null) {
      student.changeGradeOrGraduateStatus(newGradeOrGraduateStatus);
    }

    if (newLocalPhotoPath != null) {
      if (newLocalPhotoPath.contains("assets")) {
        student.changeProfilePhoto(ProfilePhotoPath(newLocalPhotoPath));
      } else {
        final profilePhotoPath = createPathFromId(studentId);
        final image = resize(newLocalPhotoPath);
        final profilePhoto =
            ProfilePhoto.fromImage(path: profilePhotoPath, image: image);
        await _photoRepository.save([profilePhoto]);
        final oldPhotoPath = student.profilePhotoPath;
        student.changeProfilePhoto(profilePhotoPath);

        final cond1 =
            oldPhotoPath.value != "profile_photo/default/male_default.jpg";
        final cond2 =
            oldPhotoPath.value != "profile_photo/default/female_default.jpg";
        final cond3 = !oldPhotoPath.value.contains("assets");
        if (cond1 && cond2 && cond3) {
          await _photoRepository.delete(oldPhotoPath);
        }
        await _repository.save(student);
      }
    }

    await _repository.save(student);
  }
}
