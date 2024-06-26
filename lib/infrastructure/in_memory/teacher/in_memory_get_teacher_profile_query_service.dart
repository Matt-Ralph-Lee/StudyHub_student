import '../../../application/shared/session/session.dart';
import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../../application/teacher/application_service/i_get_teacher_profile_query_service.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../blockings/in_memory_blockings_repository.dart';
import '../favorite_teachers/in_memory_favorite_teachers_repository.dart';
import 'in_memory_teacher_repository.dart';

class InMemoryGetTeacherProfileQueryService
    implements IGetTeacherProfileQueryService {
  final Session _session;
  final InMemoryTeacherRepository _repository;
  final InMemoryFavoriteTeachersRepository _favoriteTeachersRepository;
  final InMemoryBlockingsRepository _blockingsRepository;

  InMemoryGetTeacherProfileQueryService({
    required final Session session,
    required final InMemoryTeacherRepository repository,
    required final InMemoryFavoriteTeachersRepository
        favoriteTeachersRepository,
    required final InMemoryBlockingsRepository blockingsRepository,
  })  : _session = session,
        _repository = repository,
        _favoriteTeachersRepository = favoriteTeachersRepository,
        _blockingsRepository = blockingsRepository;

  @override
  Future<GetTeacherProfileDto?> findById(TeacherId teacherId) async {
    final teacher = await _repository.getByTeacherId(teacherId);
    if (teacher == null) return null;

    final studentId = _session.studentId;
    final favoriteTeachers =
        await _favoriteTeachersRepository.getByStudentId(studentId);
    bool isFollowing = false;

    if (favoriteTeachers != null) {
      if (favoriteTeachers.contains(teacher.teacherId)) {
        isFollowing = true;
      }
    }

    final isBlocking = await _blockingsRepository.checkTeacherIsBlocking(
        studentId: studentId, teacherId: teacherId);

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
      isBlocking: isBlocking,
      rating: teacher.rating.value,
    );
  }
}
