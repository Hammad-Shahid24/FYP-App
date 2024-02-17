import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fypapp/models/appointment_model.dart';

import '../shared_preferences/sp_service.dart';

class AppointmentDatabaseService {

  final CollectionReference appointmentCollection = FirebaseFirestore.instance.collection('appointments');

  AppointmentDatabaseService();

  factory AppointmentDatabaseService.start() {
    return AppointmentDatabaseService();
  }

  Future<List<AppointmentModel>> getPatientAppointments() async {
    String patientId = await SharedPreferencesService().getUserId;
    final snapshot = await appointmentCollection.where('patient_id', isEqualTo: patientId).get();
    return List.generate(snapshot.docs.length, (index) {
      return AppointmentModel.fromJson(snapshot.docs[index].data() as Map<String, dynamic>);
    });
  }

  Future<List<AppointmentModel>> getDoctorAppointments() async {
    String docId = await SharedPreferencesService().getUserId;
    final snapshot = await appointmentCollection.where('doctor_id', isEqualTo: docId).get();
    return List.generate(snapshot.docs.length, (index) {
      return AppointmentModel.fromJson(snapshot.docs[index].data() as Map<String, dynamic>);
    });
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    final docRef = await appointmentCollection.add(appointment.toJson());
    await docRef.update({'id': docRef.id});
  }

}