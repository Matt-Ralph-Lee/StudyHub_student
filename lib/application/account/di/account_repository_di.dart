import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/account/models/i_account_repository.dart';
import '../../common/flavor.dart';
import '../../common/flavor_config.dart';

final accountRepositoryProvider = Provider<IAccountRepository>(
  (ref) {
    switch (flavor) {
      case Flavor.dev:
      // TODO: 各リポジトリの完成に応じて書くこと
      case Flavor.stg:
      case Flavor.prd:
    }
  },
);
