import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/pages/splash.page.dart';
import 'package:recipe_app/services/prefrences.service.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();

    GetIt.I.registerSingleton<SharedPreferences>(preference);

    // if (preference != null) {
    //   print(
    //       '========================= prefrences init Successfully ========================');
    // }
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
        fontFamily: 'Hellix',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xfff45b00),
          primary: Color(0xfff45b00),
          secondary: Color(0xfff45b00),
        ),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
