// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferencesProvider extends ChangeNotifier {
//   late SharedPreferences _prefs;
//
//   String? _firebaseAuthId;
//   bool? _isPatient;
//
//   SharedPreferencesProvider() {
//     _initPrefs();
//   }
//
//   Future<void> _initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//     _firebaseAuthId = _prefs.getString('firebaseAuthId');
//     _isPatient = _prefs.getBool('isPatient');
//     notifyListeners();
//     print("Shared Preferences Provider Initialized");
//   }
//
//   String? get savedString => _firebaseAuthId;
//   bool? get isPatient => _isPatient;
//
//   void saveAuthId(String value) async {
//     // await _initPrefs();
//     await _prefs.setString('firebaseAuthId', value);
//     _firebaseAuthId = value;
//     print(_firebaseAuthId);
//     notifyListeners();
//   }
//
//   void saveIsPatientOrDoctor(bool value) {
//     _prefs.setBool('isPatient', value);
//     _isPatient = value;
//     notifyListeners();
//   }
//
//   void resetSharedPreferences() {
//     _prefs.remove('firebaseAuthId');
//     _prefs.remove('isPatient');
//     _firebaseAuthId = null;
//     _isPatient = null;
//     notifyListeners();
//   }
// }
