import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fypapp/firebase_options.dart';
import 'package:fypapp/views/different_users_views.dart';
import 'package:fypapp/views/home_view.dart';
import 'package:fypapp/views/signin_view.dart';
import 'package:fypapp/views/signup_view.dart';

import 'constants/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      home: const Choices(),
    );
  }
}
