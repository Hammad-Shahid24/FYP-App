import 'package:flutter/material.dart';
import 'package:fypapp/components/doc_card.dart';
import 'package:fypapp/models/doctor_model.dart';
import 'package:provider/provider.dart';
import '../providers/doc_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient\'s List'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<DoctorModel>>(
          stream: context.read<DocProvider>().getDocs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final doctors = snapshot.data;
            return ListView.builder(
                itemCount: doctors!.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DocCard(docName: doctor.name,
                      docSpeciality: doctor.specialization,
                      availability: doctor.availability,
                      dutyStartTime: doctor.dutyStartTime,
                      dutyEndTime: doctor.dutyEndTime,
                      hospitalName: doctor.hospitalName,
                    ontap: () {

                    },);
                }
            );
          }),
    );
  }
}
