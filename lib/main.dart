import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/app/app.dart';
import 'package:project_pulse/app/app_initializer.dart';


Future<void> main() async {
    await AppInitializer.initialize();

  runApp(const ProviderScope(child: ProjectPulseApp()));
}

