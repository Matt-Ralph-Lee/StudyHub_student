import '../../../application/blockings/application_service/get_blocking_dto.dart';
import '../../../application/blockings/application_service/i_get_blockings_query_service.dart';
import '../../../domain/student/models/student_id.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_blockings_repository.dart';

class FirebaseBlockingsQueryService implements IGetBlockingsQueryService {
  final FirebaseBlockingsRepository _repository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseBlockingsQueryService({
    required final FirebaseBlockingsRepository repository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<GetBlockingDto>> getByStudentId(StudentId studentId) async {
    final blockingIds = await _repository.getByStudentId(studentId);
    if (blockingIds == null) {
      return [];
    }

    final blockingDtos = <GetBlockingDto>[];

    for (final blockingId in blockingIds) {
      final blocking = await _teacherRepository.getByTeacherId(blockingId);
      if (blocking == null) continue;

      blockingDtos.add(GetBlockingDto(
        teacherId: blocking.teacherId,
        teacherName: blocking.name.value,
      ));
    }

    return blockingDtos;
  }
}
