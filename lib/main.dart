import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/firebase_options.dart';
import 'package:studyhub/presentation/router/app.dart';

void main() async {
  const app = App();
  const scope = ProviderScope(child: app);
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(scope);
}
