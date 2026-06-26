import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_pulse/features/home/domain/entities/home_summary_entity.dart';
import 'package:project_pulse/features/home/presentation/providers/home_notifier.dart';

final homeProvider =
    AsyncNotifierProvider<HomeNotifier, HomeSummary>(HomeNotifier.new);
  
// Tracks which tab is active across the app.
final shellIndexProvider = StateProvider<int>((ref) => 0);
