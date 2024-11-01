import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/report/models/i_question_report_repository.dart';
import '../../../infrastructure/firebase/report/firebase_question_report_repository.dart';
import '../../../infrastructure/in_memory/report/in_memory_question_report_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'question_report_repository_provider.g.dart';

@riverpod
IQuestionReportRepository questionReportRepositoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryQuestionReportRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseQuestionReportRepository();
  }
}
