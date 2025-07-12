import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() {
  // Starts the Flutter application, covering it with ProviderScope
  // to enable state management with Riverpod.
  runApp(
    const ProviderScope(
      child: AwakeiaApp(),
    ),
  );
}
