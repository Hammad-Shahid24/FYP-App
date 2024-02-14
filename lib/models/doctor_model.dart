class DoctorModel {
  final String id;
  final String name;
  final String regNumber;
  final String specialization;
  final String hospitalId;
  // final String image;
  // final String rating;
  final String dutyStartTime;
  final String dutyEndTime;

  DoctorModel({
    required this.id,
    required this.name,
    required this.regNumber,
    required this.specialization,
    required this.hospitalId,
    // required this.image,
    // required this.rating,
    required this.dutyStartTime,
    required this.dutyEndTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      regNumber: json['regNumber'],
      specialization: json['specialization'],
      hospitalId: json['hospitalId'],
      // image: json['image'],
      // rating: json['rating'],
      dutyStartTime: json['dutyStartTime'],
      dutyEndTime: json['dutyEndTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'regNumber': regNumber,
      'specialization': specialization,
      'hospitalId': hospitalId,
      // 'image': image,
      // 'rating': rating,
      'dutyStartTime': dutyStartTime,
      'dutyEndTime': dutyEndTime,
    };
  }
}
