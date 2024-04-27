import '../database.dart';

import '../../../domain/school/models/i_school_repository.dart';
import '../../../domain/school/models/school.dart';
import '../../../domain/school/models/school_type.dart';

class FirebaseSchoolRepository implements ISchoolRepository {
  final db = Database.db;

  static final FirebaseSchoolRepository _instance =
      FirebaseSchoolRepository._internal();

  factory FirebaseSchoolRepository() {
    return _instance;
  }

  FirebaseSchoolRepository._internal();

  @override
  Future<bool> exists(School school, {SchoolType? schoolType}) async {
    return true;
  }
}
