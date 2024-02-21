import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fypapp/services/database/hospital_database_helper.dart';
import '../models/hospital_model.dart';

class HospitalProvider extends ChangeNotifier {
  final HospitalDatabaseHelper _hospitalDatabaseHelper;

  HospitalProvider(this._hospitalDatabaseHelper);

  Future<List<HospitalModel>> getHospitals() async {
    return await _hospitalDatabaseHelper.getHospitals();
  }

  Future<HospitalModel> getHospital(DocumentReference docRef) async {
    return await _hospitalDatabaseHelper.getHospital(docRef);
  }

  Future<String> getHospitalName(DocumentReference docRef) async {
    HospitalModel hospital = await _hospitalDatabaseHelper.getHospital(docRef);
      return hospital.name;
  }

}