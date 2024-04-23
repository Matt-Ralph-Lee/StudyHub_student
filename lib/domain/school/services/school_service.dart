import '../models/i_school_repository.dart';
import '../models/school.dart';
import '../models/school_type.dart';

class SchoolService {
  final ISchoolRepository _repository;

  SchoolService(this._repository);

  Future<bool> exists({
    required final School school,
    required final SchoolType? schoolType,
  }) {
    return _repository.exists(school, schoolType: schoolType);
  }
}
