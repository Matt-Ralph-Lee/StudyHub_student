import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studyhub/application/shared/flavor/flavor.dart';
import 'package:studyhub/application/shared/flavor/flavor_config.dart';

class Database {
  static final db = switch (flavor) {
    Flavor.dev => throw Exception("you're not suppose to use firebase in dev"),
    Flavor.stg => FirebaseFirestore.instanceFor(
        app: Firebase.app(),
        databaseId: "test",
      ),
    Flavor.prd => FirebaseFirestore.instance,
  };
}
