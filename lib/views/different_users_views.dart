import 'package:flutter/material.dart';

import '../constants/routes.dart';

class Choices extends StatelessWidget {
  const Choices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(adminRoute);
                },
                child: const Text('Admin'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(deanRoute);
                },
                child: const Text('Dean'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(doctorRoute);
                },
                child: const Text('Doctor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(signInRoute);
                },
                child: const Text('patient'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}