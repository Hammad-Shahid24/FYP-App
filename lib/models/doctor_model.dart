import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorModel {
  final String id;
  final String name;
  final String regNumber;
  final String specialization;
  final DocumentReference hospitalId;
  final String hospitalName;
  final String availability;
  // final String image;
  // final String rating;
  final TimeOfDay dutyStartTime;
  final TimeOfDay dutyEndTime;

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
          dutyStartTime: TimeOfDay.fromDateTime(DateTime.parse(doc['duty_start_time'])),
          dutyEndTime: TimeOfDay.fromDateTime(DateTime.parse(doc['duty_end_time'])),
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reg_number': regNumber,
      'specialization': specialization,
      'hospital_id': hospitalId,
      'hospital_name': hospitalName,
      'availability': availability,
      'duty_start_time': dutyStartTime,
      'duty_end_time': dutyEndTime,
    };
  }
}
