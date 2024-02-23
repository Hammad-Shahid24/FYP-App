import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fypapp/components/alert_dialog.dart';
import 'package:fypapp/constants/routes.dart';
import 'package:fypapp/providers/doc_provider.dart';
import 'package:fypapp/providers/patient_provider.dart';
import 'package:fypapp/services/auth/auth_service.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool obscureText = true;
    bool isDoctor = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Here!',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SvgPicture.asset('assets/2.svg', height: 200, width: 300),
                const SizedBox(height: 50),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const UnderlineInputBorder(),
                        icon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: obscureText
                              ? const Icon(Icons.visibility_off)
                              : Icon(Icons.visibility,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: obscureText,
                    );
                  },
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Row(
                    children: <Widget>[
                      Checkbox(
                        value: isDoctor,
                        onChanged: (newValue) {
                          setState(() {
                            isDoctor = newValue!;
                          });
                        },
                        activeColor: Colors.blue, // Set the color for the checkbox when selected
                      ),
                      Text('           Sign up as a doctor',
                        style: TextStyle(fontSize: 16, color: Theme.of(context)
                        .primaryColor),
                      ),
                    ],
                  );
                }
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final user = await AuthService.firebase().createUser(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          await AuthService.firebase().sendEmailVerification();
                          SharedPreferencesService.start().saveAuthId(user.uid!);
                          SharedPreferencesService.start().saveIsDoctor(isDoctor);
                          isDoctor
                              ? context.read<DocProvider>().addDoctor()
                              : context.read<PatientProvider>().addPatient();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute, (route) => false,
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return MyDialog(onPressed: () {
                                // nothing needed here
                              },
                                title: 'Error',
                                content: e.toString(),
                                icon: Icons.error_outline,);
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Sign Up')
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(signInRoute, (route) => false);
                  },
                  child: const Text('Already have an account? Sign in here.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
