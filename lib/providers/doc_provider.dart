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

}