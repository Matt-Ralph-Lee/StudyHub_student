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
}
