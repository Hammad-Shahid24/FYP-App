/* i had to make this provider because i was not ablt to access the shared
 preferences in the main.dart's future builder so i thought that i should
make a provider for it and then access it in the future builder */

import 'package:flutter/material.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';

class SignInHelperProvider extends ChangeNotifier {
  final SharedPreferencesService _spService;
  late String userId;
  late bool isPatient;
  late bool isFormFilled;

  SignInHelperProvider(this._spService) {
    initializeVariables();
  }

  factory SignInHelperProvider.fromSharedPreference(spService) {
    return SignInHelperProvider(spService);
  }

  void initializeVariables() async {
    isFormFilled = await _spService.isFormFilled;
    isPatient = await _spService.isPatient;
    userId = await _spService.getUserId;
    notifyListeners();
  }

}
