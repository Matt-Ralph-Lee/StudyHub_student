import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/repositories/firebase_logger.dart';
import '../../../infrastructure/repositories/in_memory_logger.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'logger_provider.g.dart';

@riverpod
ILogger loggerDi(LoggerDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryLogger();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      return FirebaseLogger();
  }
}
