import '../blockings/in_memory_blockings_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';

import '../../../application/blockings/application_service/get_blocking_dto.dart';
import '../../../application/blockings/application_service/i_get_blockings_query_service.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/blockings/models/blockings.dart';

class InMemoryBlockingsQueryService implements IGetBlockingsQueryService {
  final InMemoryBlockingsRepository _repository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemoryBlockingsQueryService({
    required final InMemoryBlockingsRepository repository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _teacherRepository = teacherRepository;
  @override
  Future<List<GetBlockingDto>> getByStudentId(StudentId studentId) async {
    final blockings = await _repository.getByStudentId(studentId);
    if (blockings == null) {
      _repository.save(
        Blockings(
          studentId: studentId,
          teacherIdList: {},
        ),
      );
      return [];
    }

    List<GetBlockingDto> blockedTeachers = [];

    for (final TeacherId blockedTeacherId in blockings) {
      final blockedTeacher =
          await _teacherRepository.getByTeacherId(blockedTeacherId);
      if (blockedTeacher == null) continue;
      blockedTeachers.add(
        GetBlockingDto(
          teacherId: blockedTeacher.teacherId,
          teacherName: blockedTeacher.name.value,
        ),
      );
    }

    return blockedTeachers;
  }
}
