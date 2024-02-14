import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String name;
  final String regNumber;
  final String specialization;
  final String hospitalId;
  final String hospitalName;
  final String availability;
  // final String image;
  // final String rating;
  final Timestamp dutyStartTime;
  final Timestamp dutyEndTime;

  DoctorModel({
    required this.id,
    required this.name,
    required this.regNumber,
    required this.specialization,
    required this.hospitalId,
    required this.hospitalName,
    required this.availability,
    // required this.image,
    // required this.rating,
    required this.dutyStartTime,
    required this.dutyEndTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> doc) {
    return DoctorModel(
          id: doc['id'],
          name: doc['name'],
          regNumber: doc['reg_number'],
          specialization: doc['specialization'],
          hospitalId: doc['hospital_id'],
          hospitalName: doc['hospital_name'],
          availability: doc['availability'],
          dutyStartTime: doc['duty_start_time'],
          dutyEndTime: doc['duty_end_time'],
        );
  }
}
