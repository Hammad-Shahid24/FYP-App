import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  String? _firebaseAuthId;
  bool? _isPatient;

  SharedPreferencesProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // Retrieve the saved string from SharedPreferences when initialized
    _firebaseAuthId = _prefs.getString('firebaseAuthId');
    _isPatient = _prefs.getBool('isPatient');
    notifyListeners();
  }

  String? get savedString => _firebaseAuthId;
  bool? get isPatient => _isPatient;

  void saveAuthId(String value) {
    _prefs.setString('firebaseAuthId', value);
    _firebaseAuthId = value;
    notifyListeners();
  }

  void saveIsPatientOrDoctor(bool value) {
    _prefs.setBool('isPatient', value);
    _isPatient = value;
    notifyListeners();
  }

  void resetSharedPreferences() {
    _prefs.remove('firebaseAuthId');
    _prefs.remove('isPatient');
    _firebaseAuthId = null;
    _isPatient = null;
    notifyListeners();
  }
}
