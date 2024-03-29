import 'package:flutter/material.dart';
import 'package:fypapp/constants/routes.dart';
import 'package:fypapp/models/appointment_model.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:provider/provider.dart';
import '../components/doc_card.dart';
import '../providers/appointment_provider.dart';

class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doctor\'s View'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthService.firebase().logOut();
                SharedPreferencesService.start().resetSharedPreferences();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  signInRoute,
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<AppointmentModel>>(
          future: context.read<AppointmentProvider>().getDoctorAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error message if an error occurs
            } else if (snapshot.hasData) {
              // Data is available, so we can safely access it
              List<AppointmentModel> appointments = snapshot.data!;
              // Build your UI using the appointment data
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  AppointmentModel appointment = appointments[index];
                  return DocCard(
                    docName: appointment.id,
                    docSpeciality: appointment.doctorId,
                    availability: appointment.patientId,
                    dutyStartTime:
                        TimeOfDay.fromDateTime(appointment.updatedAt),
                    dutyEndTime: TimeOfDay.fromDateTime(appointment.createdAt),
                    hospitalName: (appointment.status),
                    ontap: () {},
                  );
                },
              );
            } else {
              return const Text(
                  'No data available'); // Handle case where snapshot has no data
            }
          },
        ));
  }
}
