import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/presentation/router/app.dart';

void main() {
  const app = App();
  const scope = ProviderScope(child: app);
  // debugPaintSizeEnabled = false;
  runApp(scope);
}
