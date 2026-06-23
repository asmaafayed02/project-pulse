import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../core/routes/app_router.dart';
import '../core/theme/app_theme.dart';

class ProjectPulseApp extends StatelessWidget {
  const ProjectPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          title: 'ProjectPulse',

          theme: AppTheme.light,

          darkTheme: AppTheme.dark,

          themeMode: ThemeMode.system,

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}