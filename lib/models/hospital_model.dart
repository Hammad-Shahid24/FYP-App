class HospitalModel {
  final String id;
  final String name;
  final String address;
  final String location;
  final String deanName;

  HospitalModel({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.deanName});

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      location: json['location'],
      deanName: json['dean_name'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'address': address,
  //     'location': location,
  //     'dean_name': deanName,
  //     'updated_at': DateTime.now(),
  //   };
  // }

}