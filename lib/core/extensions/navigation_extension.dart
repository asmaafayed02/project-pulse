import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppRouterExtension on BuildContext {
  void pushTo(
    String route, {
    Object? extra,
  }) {
    push(route, extra: extra);
  }

  void replaceTo(
    String route, {
    Object? extra,
  }) {
    pushReplacement(route, extra: extra);
  }

  void goTo(
    String route, {
    Object? extra,
  }) {
    go(route, extra: extra);
  }

  void popPage<T extends Object?>([T? result]) {
    pop(result);
  }
}