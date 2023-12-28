import 'package:flutter/material.dart';
import 'package:recipe_app/pages/splash.page.dart';
import 'package:recipe_app/services/prefrences.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    PrefrencesService.prefs = await SharedPreferences.getInstance();

    if (PrefrencesService.prefs != null) {
      print(
          '========================= prefrences init Successfully ========================');
    }
  } catch (e) {
    print(
        '=========================Error In init Prefrences ${e}========================');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xfff45b00),
            primary: Color(0xfff45b00),
            secondary: Color(0xfff45b00)),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
