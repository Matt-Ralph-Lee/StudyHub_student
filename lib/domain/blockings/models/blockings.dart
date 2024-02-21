import '../exception/blockings_domain_exception.dart';
import '../exception/blockings_domain_exception_detail.dart';

import '../../teacher/models/teacher_id.dart';
import '../../student/models/student_id.dart';

class Blockings extends Iterable {
  final StudentId _studentId;
  final List<TeacherId> _teacherIdList;

  StudentId get studentId => _studentId;
  List<TeacherId> get teacherIdList => _teacherIdList;

  Blockings({
    required StudentId studentId,
    required List<TeacherId> teacherIdList,
  })  : _studentId = studentId,
        _teacherIdList = teacherIdList {
    if (_teacherIdList.toSet().toList().length != _teacherIdList.length) {
      throw const BlockingsDomainException(
          BlockingsDomainExceptionDetail.duplicateTeacher);
    }
  }

  void add(TeacherId newTeacherId) {
    if (_teacherIdList.contains(newTeacherId)) {
      throw const BlockingsDomainException(
          BlockingsDomainExceptionDetail.duplicateTeacher);
    }
    _teacherIdList.add(newTeacherId);
  }

  void delete(TeacherId teacherId) {
    if (!_teacherIdList.contains(teacherId)) {
      throw const BlockingsDomainException(
          BlockingsDomainExceptionDetail.teacherNotFound);
    }
    _teacherIdList.remove(teacherId);
  }

  bool canDelete(StudentId studentId) {
    return _studentId == studentId;
  }

  @override
  Iterator get iterator => _teacherIdList.iterator;
}
