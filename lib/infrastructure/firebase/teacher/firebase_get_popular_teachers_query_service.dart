import '../database.dart';

import '../../../application/teacher/application_service/i_get_popular_teachers_query_service.dart';
import '../../../application/teacher/application_service/search_for_teachers_dto.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class FirebaseGetPopularTeachersQueryService
    implements IGetPopularTeachersQueryService {
  final db = Database.db;

  @override
  Future<List<SearchForTeacherDto>> find() async {
    final searchForTeacherDtoList = <SearchForTeacherDto>[];

    final querySnapshot =
        await db.collection("teachers").orderBy("ratingSum").limit(100).get();

    for (final docSnapshot in querySnapshot.docs) {
      final doc = docSnapshot.data();

      final teacherId = docSnapshot.reference.id;
      final name = doc["name"] as String;
      final profilePhoto = doc["profilePhoto"] as String;
      final bio = doc["BIO"] as String;

      final dto = SearchForTeacherDto(
        teacherId: TeacherId(teacherId),
        name: name,
        profilePhotoPath: profilePhoto,
        bio: bio,
      );

      searchForTeacherDtoList.add(dto);
    }

    return searchForTeacherDtoList;
  }
}
