
import 'package:flutter/material.dart';

class DocCard extends StatelessWidget {
  const DocCard(
      {super.key,
      required this.docName,
      required this.docSpeciality,
      required this.availability,
      required this.dutyStartTime,
      required this.dutyEndTime,
      required this.hospitalName,
        required this.ontap});

  final String docName;
  final String docSpeciality;
  final String availability;
  final TimeOfDay dutyStartTime;
  final TimeOfDay dutyEndTime;
  final String hospitalName;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                docName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                docSpeciality,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Text(
                'Availability: $availability',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Duty Time: $dutyStartTime - $dutyEndTime',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Hospital: $hospitalName',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}