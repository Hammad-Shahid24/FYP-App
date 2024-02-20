import 'package:flutter/material.dart';
import 'package:fypapp/components/doc_card.dart';
import 'package:fypapp/models/doctor_model.dart';
import 'package:provider/provider.dart';
import '../providers/doc_provider.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient\'s View'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<DoctorModel>>(
          stream: context.read<DocProvider>().getDocs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              var v = DateTime.now();
              print(v);
              return Center(
                child: Text('An error occurred: ${snapshot.error}'),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
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
              default:
                return const Center(
                  child: Text('Something went wrong'),
                );
            }
          }),
    );
  }
}
