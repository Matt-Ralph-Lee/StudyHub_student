import '../../../application/shared/session/session.dart';
import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../../application/teacher/application_service/i_get_teacher_profile_query_service.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../favorite_teachers/firebase_favorite_teachers_repository.dart';
import 'firebase_teacher_repository.dart';

class FirebaseGetTeacherProfileQueryService
    implements IGetTeacherProfileQueryService {
  final FirebaseTeacherRepository _repository;
  final FirebaseFavoriteTeachersRepository _favoriteTeachersRepository;
  final Session _session;

  FirebaseGetTeacherProfileQueryService({
    required final Session session,
    required final FirebaseTeacherRepository repository,
    required final FirebaseFavoriteTeachersRepository favoriteTeacherRepository,
  })  : _session = session,
        _repository = repository,
        _favoriteTeachersRepository = favoriteTeacherRepository;
  @override
  Future<GetTeacherProfileDto?> findById(TeacherId teacherId) async {
    final teacher = await _repository.getByTeacherId(teacherId);
    if (teacher == null) return null;

    final studentId = _session.studentId;
    final favoriteTeachers =
        await _favoriteTeachersRepository.getByStudentId(studentId);

    final isFollowing = favoriteTeachers != null &&
        favoriteTeachers.contains(teacher.teacherId);

    return GetTeacherProfileDto(
      name: teacher.name.value,
      profilePhotoPath: teacher.profilePhotoPath.value,
      highSchool: teacher.highSchool.value,
      university: teacher.university.value,
      enrollmentStatus: teacher.university.enrollmentStatus.japanese,
      bestSubjects:
          teacher.bestSubjects.map((subject) => subject.japanese).toList(),
      bio: teacher.bio.value,
      introduction: teacher.introduction.value,
      isFollowing: isFollowing,
      rating: teacher.rating.value,
    );
  }
}
