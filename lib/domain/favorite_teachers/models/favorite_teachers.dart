import '../exception/favorite_teachers_domain_exception.dart';
import '../exception/favorite_teachers_domain_exception_detail.dart';

import '../../teacher/models/teacher_id.dart';
import '../../student/models/student_id.dart';

class FavoriteTeachers {
  static const maxLength = 5;
  final StudentId _studentId;
  final List<TeacherId> _teacherIdList;

  StudentId get studentId => _studentId;
  List<TeacherId> get teacherIdList => _teacherIdList;
  int get length => _teacherIdList.length;

  FavoriteTeachers({
    required StudentId studentId,
    required List<TeacherId> teacherIdList,
  })  : _studentId = studentId,
        _teacherIdList = teacherIdList {
    if (_teacherIdList.length > maxLength) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.invalidTeacherLength);
    }
    if (_teacherIdList.toSet().toList().length != _teacherIdList.length) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.duplicateTeacher);
    }
  }

  TeacherId operator [](int index) {
    if (index < 0 || index >= _teacherIdList.length) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.invalidIndex);
    }
    return _teacherIdList[index];
  }

  void add(TeacherId newTeacherId) {
    if (_teacherIdList.length >= maxLength) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.invalidTeacherLength);
    }
    if (_teacherIdList.contains(newTeacherId)) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.duplicateTeacher);
    }
    _teacherIdList.add(newTeacherId);
  }

  void delete(TeacherId teacherId) {
    if (!_teacherIdList.contains(teacherId)) {
      throw const FavoriteTeachersDomainException(
          FavoriteTeachersDomainExceptionDetail.teacherNotFound);
    }
    _teacherIdList.remove(teacherId);
  }

  bool canDelete(StudentId studentId) {
    return _studentId == studentId;
  }
}
