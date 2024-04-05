import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/teacher/application_service/i_search_for_teachers_query_service.dart';
import '../../../application/teacher/application_service/search_for_teachers_dto.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class FirebaseSearchForTeachersQueryService
    implements ISearchForTeachersQueryService {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<SearchForTeacherDto>?> search(String keywordString) async {
    final searchForTeacherDtoList = <SearchForTeacherDto>[];

    final querySnapshot = await db
        .collection("teachers")
        .where("teacherNameTokenMap.$keywordString", isEqualTo: true)
        .get();

    for (final docSnapshot in querySnapshot.docs) {
      final doc = docSnapshot.data();

      final teacherId = docSnapshot.reference.id;
      final name = doc["name"];
      final profilePhotoPath = doc["profilePhoto"];
      final bio = doc["BIO"];

      final searchForTeacherDto = SearchForTeacherDto(
        teacherId: TeacherId(teacherId),
        name: name,
        profilePhotoPath: profilePhotoPath,
        bio: bio,
      );

      searchForTeacherDtoList.add(searchForTeacherDto);
    }

    return searchForTeacherDtoList;
  }
}
