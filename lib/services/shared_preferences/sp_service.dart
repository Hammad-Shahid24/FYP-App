import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  late SharedPreferences _prefs;

  SharedPreferencesService();

  factory SharedPreferencesService.start() => SharedPreferencesService();

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    print("Shared Preferences Provider Initialized");
  }

  void get getUserId async {
    await _initialize();
    var id = _prefs.getString('firebaseAuthId');
    print(id);
  }

  void get isPatient async {
    print('');
  }

  void saveAuthId(String value) async {
    await _initialize();
    await _prefs.setString('firebaseAuthId', value);
  }

  void saveIsPatientOrDoctor(bool value) {
    _prefs.setBool('isPatient', value);
  }

  void resetSharedPreferences() {
    _prefs.remove('firebaseAuthId');
    _prefs.remove('isPatient');

  }
}