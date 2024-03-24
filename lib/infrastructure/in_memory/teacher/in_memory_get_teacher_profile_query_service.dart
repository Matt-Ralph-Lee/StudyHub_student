import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../../application/teacher/application_service/i_get_teacher_profile_query_service.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import 'in_memory_teacher_repository.dart';

class InMemoryGetTeacherProfileQueryService
    implements IGetTeacherProfileQueryService {
  final InMemoryTeacherRepository _repository;

  InMemoryGetTeacherProfileQueryService(this._repository);

  @override
  GetTeacherProfileDto? findById(TeacherId teacherId) {
    final teacher = _repository.getByTeacherId(teacherId);
    if (teacher == null) return null;

    return GetTeacherProfileDto(
        name: teacher.name.value,
        profilePhotoPath: teacher.profilePhotoPath.value,
        highSchool: teacher.highSchool.value,
        university: teacher.university.value,
        enrollmentStatus: "", //TODO: 空にしてます。必要ですかねぇ、そもそも　在籍云々だと思うのですが
        bestSubjects:
            teacher.bestSubjects.map((subject) => subject.japanese).toList(),
        bio: teacher.bio.value,
        introduction: teacher.introduction.value);
  }
}
