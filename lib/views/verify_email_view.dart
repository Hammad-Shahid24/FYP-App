import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late final bool isDoctor;
  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  void checkEmailVerification() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        SharedPreferencesService.start().saveAuthId(user.uid);
        SharedPreferencesService.start().saveIsDoctor(isDoctor);
        isDoctor
            ? Navigator.of(context).pushNamedAndRemoveUntil(
          doctorFormRoute, (route) => false,
        )
            : Navigator.of(context).pushNamedAndRemoveUntil(
          patientFormRoute, (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isDoctor = args['isDoctor'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "We've sent you an email verification."
                  " Please open it to verify your account.\n"
                  "If you haven't received a verification email yet,"
                  " press the button below to resend it.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5,),
            const RefreshProgressIndicator(),
            const SizedBox(height: 5,),
            const Text('Waiting for you the verify your email.'),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () async {
                  await AuthService.firebase().sendEmailVerification();
                },
                child: const Text('Resend verification email')),
            const SizedBox(height: 10,),

            ElevatedButton(
                onPressed: () async {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    signUpeRoute,
                        (route) => false,
                  );
                },
                child: const Text('Go to Sign up page')),

          ],
        ),
      ),
    );
  }
}
