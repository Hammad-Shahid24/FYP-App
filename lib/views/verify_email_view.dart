import 'package:flutter/material.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
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
              " press the button below\nProceed to the Login if you've verified you're Email Address.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await AuthService.firebase().sendEmailVerification();
                },
                child: const Text('Send email verification')),
            ElevatedButton(
                onPressed: () async {
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified == true) {
                    SharedPreferencesService.start().saveAuthId(user!.uid!);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      patientHomeRoute,
                      (route) => false,
                    );
                  } else if (user?.isEmailVerified == false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Email not verified'),
                          content: const Text('Please verify your email'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (user == null) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      signUpeRoute,
                      (route) => false,
                    );
                  }
                },
                child: const Text("Press here After verifying your email Address")),
            ElevatedButton(
                onPressed: () async {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    signUpeRoute,
                    (route) => false,
                  );
                },
                child: const Text('Restart')),
          ],
        ),
      ),
    );
  }
}