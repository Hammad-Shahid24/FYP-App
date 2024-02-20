import 'package:flutter/material.dart';
import 'package:fypapp/services/database/appointment_database_helper.dart';

import '../models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  final AppointmentDatabaseService _appointmentDatabaseHelper;

  AppointmentProvider(this._appointmentDatabaseHelper);

  Future<List<AppointmentModel>> getDoctorAppointments() {
    return _appointmentDatabaseHelper.getDoctorAppointments();
  }

  Future<List<AppointmentModel>> getPatientAppointments() {
    return _appointmentDatabaseHelper.getPatientAppointments();
  }

  Future<void> addAppointment(AppointmentModel appointment) {
    return _appointmentDatabaseHelper.addAppointment(appointment);
  }

}