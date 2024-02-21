import 'package:flutter/material.dart';
import 'package:fypapp/services/database/doc_database_helper.dart';

import '../models/doctor_model.dart';

class DocProvider extends ChangeNotifier {
  final DocDatabaseHelper _docDatabaseHelper;

  DocProvider(this._docDatabaseHelper);

  Stream<List<DoctorModel>> getDocs() {
    return _docDatabaseHelper.getDoctors();
  }

  Future<DoctorModel> getDoc(String doctorId) {
    return _docDatabaseHelper.getDoc(doctorId);
  }

  Future<bool> doctorExists() async {
    return _docDatabaseHelper.doctorExists();
  }

  Future<void> addDoctor() async {
    return _docDatabaseHelper.addDoctor();
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    return _docDatabaseHelper.updateDoctor(doctor);
  }

  Future<void> removeDoctor(String id) async {
    return _docDatabaseHelper.removeDoctor(id);
  }

}