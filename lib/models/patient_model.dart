class PatientModel {
  final String id;
  final String displayName;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imei;
  final String phoneNumber;

  PatientModel({required this.id,
    required this.displayName,
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
      displayName: json['username'],
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
      'id': id,
      'user_name': displayName,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'gender': gender,
      'phone_number': phoneNumber,
      'imei': imei
    };
  }

}
