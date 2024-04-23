import '../../../domain/blockings/models/blockings.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class InMemoryBlockingsRepository implements IBlockingsRepository {
  late Map<StudentId, Blockings> store;
  static final InMemoryBlockingsRepository _instance =
      InMemoryBlockingsRepository._internal();

  factory InMemoryBlockingsRepository() {
    return _instance;
  }

  InMemoryBlockingsRepository._internal() {
    store = {};
  }

  @override
  Future<void> save(Blockings blockings) async {
    store[blockings.studentId] = blockings;
  }

  @override
  Future<Blockings?> getByStudentId(StudentId studentId) async {
    return store[studentId];
  }

  @override
  Future<bool> checkTeacherIsBlocking({
    required StudentId studentId,
    required TeacherId teacherId,
  }) async {
    final blockings = store[studentId];
    if (blockings == null) {
      return false;
    }
    return blockings.contains(teacherId);
  }
}
