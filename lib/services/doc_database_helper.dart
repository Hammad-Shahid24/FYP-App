import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/doctor_model.dart';

class DocDatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _docCollection = 'doctors';

  Stream<List<DoctorModel>> getDoctors() {
  return _firestore.collection(_docCollection).snapshots().map((snapshot) =>
      List<DoctorModel>.generate(snapshot.docs.length, (index) =>
          DoctorModel.fromJson(snapshot.docs[index].data())));
}


}
