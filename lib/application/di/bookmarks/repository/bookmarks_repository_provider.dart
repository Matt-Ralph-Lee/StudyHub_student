import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../../infrastructure/firebase/bookmarks/firebase_bookmarks_repository.dart';
import '../../../../infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'bookmarks_repository_provider.g.dart';

@riverpod
IBookmarksRepository bookmarksRepositoryDi(BookmarksRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryBookmarksRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseBookmarksRepository();
  }
}
