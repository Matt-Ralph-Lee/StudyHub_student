import '../database.dart';

import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class FirebaseFavoriteTeachersRepository
    implements IFavoriteTeachersRepository {
  final db = Database.db;

  static final FirebaseFavoriteTeachersRepository _instance =
      FirebaseFavoriteTeachersRepository._internal();

  factory FirebaseFavoriteTeachersRepository() {
    return _instance;
  }

  FirebaseFavoriteTeachersRepository._internal();

  @override
  Future<FavoriteTeachers?> getByStudentId(StudentId studentId) async {
    final docSnapshot =
        await db.collection("students").doc(studentId.value).get();

    final doc = docSnapshot.data();

    if (doc == null) {
      return null;
    }

    final teacherIdListData = doc["favoriteTeachers"];

    final teacherIdList = <String>[];

    for (final teacherIdData in teacherIdListData) {
      teacherIdList.add(teacherIdData);
    }

    final teacherIdSet =
        teacherIdList.map((teacherIdData) => TeacherId(teacherIdData)).toSet();

    return FavoriteTeachers(studentId: studentId, teacherIdSet: teacherIdSet);
  }

  @override
  Future<void> save(FavoriteTeachers favoriteTeachers) async {
    final docRef =
        db.collection("students").doc(favoriteTeachers.studentId.value);

    final addDataList = <String>[];

    for (final favoriteTeacher in favoriteTeachers.teacherIdSet) {
      addDataList.add(favoriteTeacher.value);
    }

    await docRef.update({"favoriteTeachers": addDataList});
  }
}
