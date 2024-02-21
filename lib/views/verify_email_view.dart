import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import '../constants/routes.dart';



class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => VerifyEmailViewState();
}

class VerifyEmailViewState extends State<VerifyEmailView> {
  Timer? _verificationCheckTimer;
  late bool? isDoctor;

  @override
  void initState() {
    setIsDoctor();
    super.initState();
    _verificationCheckTimer =
        Timer.periodic(const Duration(seconds: 2), _checkEmailVerification);
  }

  @override
  void dispose() {
    _verificationCheckTimer?.cancel();
    super.dispose();
  }

  void setIsDoctor() async {
    isDoctor = await SharedPreferencesService().getIsDoctor;
  }

  void _checkEmailVerification(Timer timer) async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      _verificationCheckTimer?.cancel();
      // Navigate to the appropriate screen for verified users
      isDoctor!
          ? Navigator.of(context).pushNamedAndRemoveUntil(
        doctorFormRoute, (route) => false,
      )
          : Navigator.of(context).pushNamedAndRemoveUntil(
        patientFormRoute, (route) => false,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
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
                      SharedPreferencesService.start()
                          .resetSharedPreferences();
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
      },
    );

  }
}

