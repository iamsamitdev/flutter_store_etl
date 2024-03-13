import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // กำหนดให้ app รอให้ flutter ทำงานเสร็จก่อน

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // ตรวจสอบว่าเคยผ่านหน้า welcome หรือยัง
  if(prefs.getBool('isWelcome') == true) {
    initRoute = AppRouter.login;
    // ตรวจสอบว่าเคยเข้าสู่ระบบหรือยัง
    if(prefs.getBool('isLogin') == true) {
      initRoute = AppRouter.dashboard;
    }
  } else {
    initRoute = AppRouter.welcome;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initRoute,
      routes: AppRouter.routes,
    );
  }
}
