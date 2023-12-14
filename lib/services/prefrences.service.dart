import 'package:shared_preferences/shared_preferences.dart';

// singelton
abstract class PrefrencesService {
  static SharedPreferences? prefs;
}
