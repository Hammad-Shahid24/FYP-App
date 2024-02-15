import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final bool isVerified;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String imei;
  final String phoneNumber;

  PatientModel({required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.imei,
    required this.phoneNumber});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      gender: json['gender'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imei: json['imei'],
      phoneNumber: json['phone_number'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': username,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'gender': gender,
      'phone_number': phoneNumber,
      'imei': imei
    };
  }
}
