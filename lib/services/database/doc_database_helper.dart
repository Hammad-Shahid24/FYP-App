import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/doctor_model.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';

class DocDatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _docCollection = 'doctors';

  Stream<List<DoctorModel>> getDoctors() {
    return _firestore.collection(_docCollection).snapshots().map((snapshot) {
      return List<DoctorModel>.generate(snapshot.docs.length, (index) {
        var doc = snapshot.docs[index];
        return DoctorModel.fromJson(doc.data());
      });
    });
  }

  Future<DoctorModel> getDoc(String doctorId) async {
    final docRef = _firestore.collection(_docCollection).doc(doctorId);
    final snapshot = await docRef.get();
    return DoctorModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  // this will come in handy in the DifferentUserView
  Future<bool> doctorExists() async {
    // Replace with the actual doctor collection path and authentication logic
    final doctorRef = _firestore.collection(_docCollection)
        .doc(await SharedPreferencesService().getUserId);

    // Replace with the appropriate field name and condition for checking doctor existence
    final snapshot = await doctorRef.get();
    return snapshot.exists; // Assuming `doctorId` is the unique identifier
  }

  Future<void> addDoctor() async {
    final id = await SharedPreferencesService().getUserId;
    await _firestore.collection(_docCollection)
        .doc(id).set({'id': id});
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    await _firestore.collection(_docCollection).doc(doctor.id).update(doctor.toJson());
  }

  Future<void> removeDoctor(String id) async {
    await _firestore.collection(_docCollection).doc(id).delete();
  }

}
