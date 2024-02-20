import 'package:flutter/material.dart';
import 'package:fypapp/providers/appointment_provider.dart';
import 'package:fypapp/providers/doc_provider.dart';
import 'package:fypapp/providers/hospital_provider.dart';
import 'package:fypapp/providers/loading_screen_provider.dart';
import 'package:fypapp/providers/patient_provider.dart';
import 'package:fypapp/providers/signin_helper_provider.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/database/appointment_database_helper.dart';
import 'package:fypapp/services/database/doc_database_helper.dart';
import 'package:fypapp/services/database/hospital_database_helper.dart';
import 'package:fypapp/services/database/patient_database_helper.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:fypapp/views/different_users_selection_view.dart';
import 'package:fypapp/views/doctor_form_view.dart';
import 'package:fypapp/views/doctor_home_view.dart';
import 'package:fypapp/views/patient_form_view.dart';
import 'package:fypapp/views/patient_home_view.dart';
import 'package:fypapp/views/loading_view.dart';
import 'package:fypapp/views/signin_view.dart';
import 'package:fypapp/views/signup_view.dart';
import 'package:fypapp/views/verify_email_view.dart';
import 'package:provider/provider.dart';
import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SignInHelperProvider(SharedPreferencesService())),
          ChangeNotifierProvider(create: (context) => AppointmentProvider(AppointmentDatabaseService())),
          ChangeNotifierProvider(create: (context) => PatientProvider(PatientDatabaseHelper())),
          ChangeNotifierProvider(create: (context) => DocProvider(DocDatabaseHelper())),
          ChangeNotifierProvider(create: (context) => LoadingScreenProvider()),
          ChangeNotifierProvider(create: (context) => HospitalProvider(HospitalDatabaseHelper()))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: const ColorScheme.light(),
              useMaterial3: true,
            ),
            routes: {
              signInRoute: (context) => const SignInView(),
              signUpeRoute: (context) => const SignUpView(),
              patientHomeRoute: (context) => const PatientHomeView(),
              verifyEmailRoute: (context) => const VerifyEmailView(),
              loadingViewRoute: (context) => const LoadingView(),
              patientFormRoute: (context) => const PatientFormView(),
              doctorHomeRoute: (context) => const DoctorHomeView(),
              differentUsersSelectionRoute: (context) => const DifferentUserSelectionView(),
            },
            home: FutureBuilder(
              future: AuthService.firebase().initialize(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    final user = AuthService.firebase().currentUser;
                    if (user != null) {
                      if (user.isEmailVerified) {
                        // if (context.watch<SignInHelperProvider>().isFormFilled) {
                        if (false) {
                          return context.watch<SignInHelperProvider>().isDoctor
                              ? const DoctorHomeView()
                              : const PatientHomeView();
                        } else {
                          return const PatientFormView();
                        }
                      } else {
                        return const VerifyEmailView();
                      }
                    } else {
                      return DoctorFormView();
                    } // No need to cast as widget
                  case ConnectionState.waiting:
                    // this finally worked
                    // context.read<SignInHelperProvider>().initializeVariables();
                    return const LoadingView();
                  case ConnectionState.active:
                    return const SignUpView();
                  case ConnectionState.none:
                    return const LoadingView();
                }
              },
            )));
  }

}
