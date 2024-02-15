import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/patient_model.dart';

class PatientDatabaseHelper{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _patientCollection = 'patients';

  Stream<List<PatientModel>> getPatients() {
    return _firestore.collection(_patientCollection).snapshots().map((snapshot) {
      return List.generate(snapshot.docs.length, (index) {
        var patient = snapshot.docs[index];
        return PatientModel.fromJson(patient.data());
      });
    });
  }

  Future<void> addPatient(PatientModel patient) async {
    final docRef = await _firestore.collection(_patientCollection).add(patient.toJson());
    final id = docRef.id;
    print(docRef);
    docRef.update({
      'id': id
    });
  }

  Future<void> removePatient(String id) async {
    await _firestore.collection(_patientCollection).doc(id).delete();
  }

  Future<void> updatePatient(PatientModel patient) async {
    await _firestore.collection(_patientCollection).doc(patient.id).update(patient.toJson());
  }


}