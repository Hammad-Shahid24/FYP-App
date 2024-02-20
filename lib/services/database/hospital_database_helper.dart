import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/hospital_model.dart';

class HospitalDatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _hospitalCollection = 'hopitals';

  Future<List<HospitalModel>> getHospitals() async {
    QuerySnapshot querySnapshot = await _firestore.collection(_hospitalCollection).get();
    return querySnapshot.docs.map((doc) {
      return HospitalModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<HospitalModel> getHospital() async {
      final docRef = _firestore.collection(_hospitalCollection).doc('lY59vdjMjXHi5pSYOKnE');
      final snapshot = await docRef.get();
      return HospitalModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

}