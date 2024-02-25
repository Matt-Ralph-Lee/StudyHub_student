import '../exception/favorite_teachers_domain_exception.dart';
import '../exception/favorite_teachers_domain_exception_detail.dart';

import '../../teacher/models/teacher_id.dart';
import '../../student/models/student_id.dart';

class FavoriteTeachers extends Iterable<TeacherId> {
  static const maxLength = 5;
  final StudentId _studentId;
  final Set<TeacherId> _teacherIdSet;

  StudentId get studentId => _studentId;
  Set<TeacherId> get teacherIdSet => _teacherIdSet;

  FavoriteTeachers({
    required final StudentId studentId,
    required final Set<TeacherId> teacherIdSet,
  })  : _studentId = studentId,
        _teacherIdSet = teacherIdSet {
    if (_teacherIdSet.length > maxLength) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.invalidTeacherLength);
    }
  }

  void add(TeacherId newTeacherId) {
    if (_teacherIdSet.length >= maxLength) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.invalidTeacherLength);
    }
    if (_teacherIdSet.contains(newTeacherId)) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.duplicateTeacher);
    }
    _teacherIdSet.add(newTeacherId);
  }

  void delete(TeacherId teacherId) {
    if (!_teacherIdSet.contains(teacherId)) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.teacherNotFound);
    }
    _teacherIdSet.remove(teacherId);
  }

  bool canDelete(StudentId studentId) {
    return _studentId == studentId;
  }

  @override
  Iterator<TeacherId> get iterator => _teacherIdSet.iterator;
}
