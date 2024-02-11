import '../../../domain/teacher/models/teacher.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher/models/i_teacher_repository.dart';

class InMemoryTeacherRepository implements ITeacherRepository {
  final store = <TeacherId, Teacher>{};
  @override
  Teacher? getByTeacherId(TeacherId teacherId) {
    return store[teacherId];
  }
}
