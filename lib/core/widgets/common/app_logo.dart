import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_sizes.dart';

class AppLogo extends StatelessWidget {
  final double? size;
  final String? assetPath;

  const AppLogo({
    super.key,
    this.size,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath ?? AppAssets.splash,
      width: size ?? AppSizes.logo110,
      height: size ?? AppSizes.logo110,
    );
  }
}