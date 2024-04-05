import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhub/domain/school/models/school.dart';
import 'package:studyhub/domain/school/models/school_type.dart';

import '../../../domain/school/models/i_school_repository.dart';

class FirebaseSchoolRepository implements ISchoolRepository {
  final db = FirebaseFirestore.instance;

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
