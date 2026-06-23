import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget withPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget center() {
    return Center(child: this);
  }
}