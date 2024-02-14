import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/doctor_model.dart';

class DocDatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _docCollection = 'doctors';

  // Stream<List<DoctorModel>> getDoctor() {
  //   return _firestore.collection(_docCollection).snapshots().map((snapshot) {
  //     return List<DoctorModel>.generate(snapshot.docs.length, (index) {
  //       return DoctorModel.fromJson(snapshot.docs[index].data());
  //     });
  //   });
  // }


  Stream<List<DoctorModel>> getDoctors() {
    return _firestore.collection(_docCollection).snapshots().asyncMap((snapshot) async {
      return List.generate(snapshot.docs.length, (index) {
        var doc = snapshot.docs[index];
        return DoctorModel.fromJson(doc.data());
      });
    });
  }

}
