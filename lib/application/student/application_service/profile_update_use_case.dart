import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/school/models/school.dart';
import '../../../domain/school/services/school_service.dart';
import '../../../domain/shared/profile_photo.dart';
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

  void execute(ProfileUpdateCommand command) {
    final studentId = _session.studentId;
    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    print("studnetはnullではない");

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
    print("occupationはおけ");

    if (newSchoolData != null) {
      final newSchool = School(newSchoolData);

      if (newSchool != School.noAnswer &&
          !_schoolService.exists(school: newSchool, schoolType: null)) {
        throw const StudentUseCaseException(
            StudentUseCaseExceptionDetail.noSchoolFound);
      }

      student.changeSchool(School(newSchoolData));
    }

    print("学校はおけ");

    if (newGradeOrGraduateStatus != null) {
      student.changeGradeOrGraduateStatus(newGradeOrGraduateStatus);
    }

    print("あとは写真のみ");

    if (newLocalPhotoPath != null) {
      final profilePhotoPath = createPathFromId(studentId);
      print("ん？");
      final image = convertToJpegAndResize(newLocalPhotoPath);
      print("はにゃ？???");
      final profilePhoto =
          ProfilePhoto.fromImage(path: profilePhotoPath, image: image);
      print("はにょ？？");
      _photoRepository.save([profilePhoto]);
      final student = _repository.findById(studentId);
      if (student == null) {
        throw const StudentUseCaseException(
            StudentUseCaseExceptionDetail.notFound);
      }
      print("nullではない");
      final oldPhotoPath = student.profilePhotoPath;
      student.changeProfilePhoto(profilePhotoPath);
      print("フッ");

      _photoRepository.delete(oldPhotoPath);
    }

    print("あとは保存のみ");

    _repository.save(student);

    print("save");
  }
}
