import 'package:flutter/widgets.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await SharedPreferences.getInstance();

    // await Hive.initFlutter();

    // await Firebase.initializeApp();

    // await ScreenUtil.ensureScreenSize();
  }
}