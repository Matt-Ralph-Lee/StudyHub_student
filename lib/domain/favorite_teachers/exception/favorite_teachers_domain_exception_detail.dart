import '../models/favorite_teachers.dart';

import '../../shared/domain_exception_detail.dart';

enum FavoriteTeachersDomainExceptionDetail implements DomainExceptionDetail {
  invalidIndex("indexが不正です。"),
  invalidTeacherLength('先生の数が多すぎます。${FavoriteTeachers.maxLength}人以内にしてください。'),
  duplicateTeacher("同じ先生が選択されています。"),
  teacherNotFound("先生が見つかりませんでした。");

  const FavoriteTeachersDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
