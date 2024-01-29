import '../../../domain/school/models/i_school_repository.dart';
import '../../../domain/school/models/school.dart';
import '../../../domain/school/models/school_type.dart';

class InMemorySchoolRepository implements ISchoolRepository {
  final store = <School, SchoolType>{
    School('第一中学校'): SchoolType.juniorHighSchool,
    School('第一高校'): SchoolType.highSchool,
    School('第一大学'): SchoolType.highSchool,
  };

  @override
  bool exists(School school, {SchoolType? schoolType}) {
    if (schoolType == null) {
      return store.containsKey(school);
    }
    return store.containsKey(school) && store[school] == schoolType;
  }
}
