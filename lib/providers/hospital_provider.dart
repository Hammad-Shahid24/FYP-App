import 'package:flutter/material.dart';
import 'package:fypapp/services/database/hospital_database_helper.dart';
import '../models/hospital_model.dart';

class HospitalProvider extends ChangeNotifier {
  final HospitalDatabaseHelper _hospitalDatabaseHelper;

  HospitalProvider(this._hospitalDatabaseHelper);

  Future<List<HospitalModel>> getHospitals() async {
    return await _hospitalDatabaseHelper.getHospitals();
  }

  Future<HospitalModel> getHospital() async {
    return await _hospitalDatabaseHelper.getHospital();
  }

}