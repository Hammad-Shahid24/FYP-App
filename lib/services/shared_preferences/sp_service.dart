import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _prefs;

  static bool userIsPatient = false;
  static bool formFilled = false;

  SharedPreferencesService();

  factory SharedPreferencesService.start() => SharedPreferencesService();

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> get getUserId async {
    await _initialize();
    return _prefs.getString('firebaseAuthId')!;
  }

  Future<bool> get isPatient async {
    await _initialize();
    return _prefs.getBool('isPatient')!;
  }

  void saveAuthId(String value) async {
    await _initialize();
    await _prefs.setString('firebaseAuthId', value);
  }

  void saveIsPatient(bool value) async{
    await _initialize();
    await _prefs.setBool('isPatient', value);
    userIsPatient = value;
  }

  void resetSharedPreferences() async{
    await _initialize();
    await _prefs.remove('firebaseAuthId');
    await _prefs.remove('isPatient');

  }

  void isFormFilled(bool value) async{
    await _initialize();
    await _prefs.setBool('formFilled', value);
    formFilled = value;
  }
}