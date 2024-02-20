import 'package:flutter/material.dart';
import 'package:fypapp/constants/routes.dart';
import 'package:fypapp/providers/doc_provider.dart';
import 'package:fypapp/providers/loading_screen_provider.dart';
import 'package:fypapp/providers/patient_provider.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:provider/provider.dart';

class DifferentUserSelectionView extends StatelessWidget {
  const DifferentUserSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select User'),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<LoadingScreenProvider>(
          builder: (BuildContext context, LoadingScreenProvider value,
              Widget? child) {
            return value.isLoading ? const CircularProgressIndicator() : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("I am a"),
                const SizedBox(height: 20), // Adjust spacing as needed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            value.setLoading(true);
                            bool res = await context.read<PatientProvider>()
                                .patientExists();

                            // SharedPreferencesService.start().saveIsPatient(res);
                          } finally {
                            value.setLoading(false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, patientHomeRoute, (route) => false);
                          }
                        },
                        child: const Text('Patient'),
                      ),
                    ),
                    const SizedBox(width: 10), // Adjust spacing as needed
                    const Text("OR"),
                    const SizedBox(width: 10), // Adjust spacing as needed
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            value.setLoading(true);
                            bool res = await context.read<DocProvider>()
                                .doctorExists();
                            if (res) {
                              // SharedPreferencesService.start().saveIsPatient(res);
                              SharedPreferencesService.start().saveIsFormFilled(true);
                            }

                          } finally {
                            value.setLoading(false);
                          }
                        },
                        child: const Text('Doctor'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
