import '../../../domain/school/models/i_school_repository.dart';
import '../../../domain/school/models/school.dart';
import '../../../domain/school/models/school_type.dart';

class InMemorySchoolRepository implements ISchoolRepository {
  late Map<School, SchoolType> store;
  static final InMemorySchoolRepository _instance =
      InMemorySchoolRepository._internal();

  factory InMemorySchoolRepository() {
    return _instance;
  }

  InMemorySchoolRepository._internal() {
    store = {
      School('第一中学校'): SchoolType.juniorHighSchool,
      School('第一高校'): SchoolType.highSchool,
      School('第一大学'): SchoolType.highSchool,
    };
  }

  @override
  Future<bool> exists(School school, {SchoolType? schoolType}) async {
    if (schoolType == null) {
      return store.containsKey(school);
    }
    return store.containsKey(school) && store[school] == schoolType;
  }
}
