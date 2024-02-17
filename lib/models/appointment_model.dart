import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String doctorId;
  final Timestamp appointmentDateTime;
  final Timestamp updatedAt;
  final Timestamp createdAt;
  final String status;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDateTime,
    required this.updatedAt,
    required this.createdAt,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      appointmentDateTime: json['appointment_date_time'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date_time': appointmentDateTime,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'status': status,
    };
  }
}