import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/report/models/i_teacher_report_repository.dart';
import '../../../infrastructure/firebase/report/firebase_teacher_report_repository.dart';
import '../../../infrastructure/in_memory/report/in_memory_teacher_report_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'teacher_report_repository_provider.g.dart';

@riverpod
ITeacherReportRepository teacherReportRepositoryDi(
    TeacherReportRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryTeacherReportRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      return FirebaseTeacherReportRepository();
  }
}
