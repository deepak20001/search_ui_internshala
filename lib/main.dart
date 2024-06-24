import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/features/splash/screens/splash_screen.dart';

var navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CommonColors.appThemeColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
