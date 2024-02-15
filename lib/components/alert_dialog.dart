import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.content,
      required this.icon});

  final VoidCallback onPressed;
  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Proceed'),
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
