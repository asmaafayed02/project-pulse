import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:project_pulse/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SharedPreferences.getInstance();

    // await Hive.initFlutter();

   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await ScreenUtil.ensureScreenSize();
  }
}