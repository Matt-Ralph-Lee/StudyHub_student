import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/infrastructure/in_memory/account_for_student/in_memory_account_repository.dart';

import '../../../domain/account_for_student/models/i_account_repository.dart';
import '../../common/flavor.dart';
import '../../common/flavor_config.dart';

final accountRepositoryProvider = Provider<IAccountRepository>(
  (ref) {
    switch (flavor) {
      case Flavor.dev:
        return InMemoryAccountRepository();
      // TODO: 各リポジトリの完成に応じて書くこと
      case Flavor.stg:
        return InMemoryAccountRepository();
      case Flavor.prd:
        return InMemoryAccountRepository();
    }
  },
);
