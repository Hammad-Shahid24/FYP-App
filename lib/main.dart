import 'package:flutter/material.dart';
import 'package:fypapp/providers/doc_provider.dart';
import 'package:fypapp/providers/patient_provider.dart';
import 'package:fypapp/providers/shared_preferences_provider.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/doc_database_helper.dart';
import 'package:fypapp/services/patient_database_helper.dart';
import 'package:fypapp/views/home_view.dart';
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
          ChangeNotifierProvider(create: (context) => DocProvider(DocDatabaseHelper())),
          ChangeNotifierProvider(create: (context) => PatientProvider(PatientDatabaseHelper())),
          ChangeNotifierProvider(create: (context) => SharedPreferencesProvider()),
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
    homeRoute: (context) => const HomeView(),
    verifyEmailRoute: (context) => const VerifyEmailView(),
    loadingViewRoute: (context) => const LoadingView(),
    },
    home: FutureBuilder(
    future: AuthService.firebase().initialize(),
    builder: (context,snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        final user = AuthService.firebase().currentUser;
        if (user != null){
          if (user.isEmailVerified) {
          return const HomeView();
          } else {
          return const VerifyEmailView();
          }
          } else {
          return const SignInView();
          }

    case (ConnectionState.waiting):
    return const LoadingView();
    case ConnectionState.active:
    return const SignUpView();
    case ConnectionState.none:
    return const LoadingView();
    }
    },
    )
    )
    );
  }
}
