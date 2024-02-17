import 'package:flutter/cupertino.dart';
import 'package:fypapp/models/patient_model.dart';
import 'package:fypapp/services/database/patient_database_helper.dart';

class PatientProvider extends ChangeNotifier{
  final PatientDatabaseHelper _databaseHelper;

  PatientProvider(this._databaseHelper);

  Stream<List<PatientModel>> getPatients() {
    return _databaseHelper.getPatients();
  }

  Future<void> addPatient(PatientModel patient) async{
    await _databaseHelper.addPatient(patient);
    notifyListeners();
  }

  Future<void> removePatient(String id) async {
    await _databaseHelper.removePatient(id);
    notifyListeners();
  }

  Future<void> updatePatient(PatientModel patient) async {
    await _databaseHelper.updatePatient(patient);
    notifyListeners();
  }

  Future<bool> patientExists() async {
    return _databaseHelper.patientExists();
  }

}
