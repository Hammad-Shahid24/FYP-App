import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/patient_model.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';

class PatientDatabaseHelper{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _patientCollection = 'patients';

  // Stream<List<PatientModel>> getPatients() {
  //   return _firestore.collection(_patientCollection).snapshots().map((snapshot) {
  //     return List.generate(snapshot.docs.length, (index) {
  //       var patient = snapshot.docs[index];
  //       return PatientModel.fromJson(patient.data());
  //     });
  //   });
  // }

  Future<void> addPatient() async {
    final id = await SharedPreferencesService().getUserId;
    await _firestore.collection(_patientCollection)
        .doc(id)
        .set({'id': id});
  }

  Future<void> removePatient(String id) async {
    await _firestore.collection(_patientCollection).doc(id).delete();
  }

  Future<void> updatePatient(PatientModel patient) async {
    await _firestore.collection(_patientCollection).doc(patient.id).update(patient.toJson());
  }

  Future<bool> patientExists(String id) async {
    // Replace with the actual doctor collection path and authentication logic
    final doctorRef = _firestore.collection(_patientCollection)
        .doc(id);

    // Replace with the appropriate field name and condition for checking doctor existence
    final snapshot = await doctorRef.get();
    return snapshot.exists; // Assuming `doctorId` is the unique identifier
  }

}