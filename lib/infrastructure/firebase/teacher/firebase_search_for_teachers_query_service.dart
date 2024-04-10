import 'dart:math';

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

    final keywordToken = [
      for (int i = 0; i < min(keywordString.length - 1, 25); i++)
        keywordString.substring(i, i + 2)
    ];

    Query<Map<String, dynamic>> query = db.collection("teachers");

    for (final token in keywordToken) {
      query = query.where("teacherNameTokenMap.$token", isEqualTo: true);
    }

    final querySnapshot = await query.get();

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
