import '../models/i_school_repository.dart';
import '../models/school.dart';

class SchoolService {
  final ISchoolRepository _repository;

  SchoolService(this._repository);

  bool exists(final School school) {
    return _repository.exists(school);
  }
}
