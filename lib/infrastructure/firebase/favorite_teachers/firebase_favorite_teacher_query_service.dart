import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart';
import '../../../application/favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../domain/student/models/student_id.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_favorite_teachers_repository.dart';

class FirebaseFavoriteTeacherQueryService
    implements IGetFavoriteTeacherQueryService {
  final db = FirebaseFirestore.instance;
  final FirebaseFavoriteTeachersRepository _repository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseFavoriteTeacherQueryService({
    required final FirebaseFavoriteTeachersRepository repository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _teacherRepository = teacherRepository;
  @override
  Future<List<GetFavoriteTeacherDto>> getById(StudentId studentId) async {
    final favoriteTeacherIds = await _repository.getByStudentId(studentId);
    if (favoriteTeacherIds == null) {
      return [];
    }

    final favoriteTeacherDtos = <GetFavoriteTeacherDto>[];

    for (final favoriteTeacherId in favoriteTeacherIds) {
      final favoriteTeacher =
          await _teacherRepository.getByTeacherId(favoriteTeacherId);
      if (favoriteTeacher == null) continue;

      favoriteTeacherDtos.add(
        GetFavoriteTeacherDto(
            teacherId: favoriteTeacherId,
            teacherName: favoriteTeacher.name.value,
            profilePhotoPath: favoriteTeacher.profilePhotoPath.value,
            bio: favoriteTeacher.bio.value),
      );
    }

    return favoriteTeacherDtos;
  }
}
