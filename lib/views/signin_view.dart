import 'package:flutter/material.dart';
import 'package:fypapp/constants/routes.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('MyDoc'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const FlutterLogo(size: 100),
                // Replace this with your hospital logo
                const SizedBox(height: 50),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).
                    pushNamedAndRemoveUntil(homeRoute, (route) => false);
                  },

                  child: const Text('Sign In'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).
                    pushNamedAndRemoveUntil(signUpeRoute, (route) => false);                  },
                  child: const Text(
                    'Haven\'t joined yet? Register here!',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
