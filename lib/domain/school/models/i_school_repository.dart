import 'school.dart';
import 'school_type.dart';

abstract class ISchoolRepository {
  Future<bool> exists(final School school, {final SchoolType? schoolType});
}
