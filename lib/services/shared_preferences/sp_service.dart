import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _prefs;

  SharedPreferencesService();

  factory SharedPreferencesService.start() => SharedPreferencesService();

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> get getUserId async {
    await _initialize();
    return _prefs.getString('firebaseAuthId')!;
  }

  Future<bool> get getIsDoctor async {
    await _initialize();
    return _prefs.getBool('isPatient')!;
  }

  Future<bool> get getIsFormFilled async {
    await _initialize();
    return _prefs.getBool('formFilled')!;
  }

  void saveAuthId(String value) async {
    await _initialize();
    await _prefs.setString('firebaseAuthId', value);
  }

  void saveIsDoctor(bool value) async{
    await _initialize();
    await _prefs.setBool('isDoctor', value);
  }

  void saveIsFormFilled(bool value) async{
    await _initialize();
    await _prefs.setBool('formFilled', value);
  }

  void resetSharedPreferences() async{
    await _initialize();
    // await _prefs.remove('firebaseAuthId');
    // await _prefs.remove('isPatient');
    // await _prefs.remove('formFilled');
    await _prefs.clear();
  }

}