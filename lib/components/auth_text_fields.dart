// import 'package:flutter/material.dart';
//
// class AuthTextField extends StatelessWidget {
//   const AuthTextField(
//       {super.key,
//       required this.controller,
//       required this.labelText,
//       this.obscureText = false});
//
//   final TextEditingController controller;
//   final String labelText;
//   final bool obscureText;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         border: const UnderlineInputBorder(),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility_off : Icons.visibility,
//           ),
//           onPressed: () {
//             setState(() {
//               obscureText = !obscureText;
//             });
//           },
//         ),
//       ),
//       obscureText: obscureText,
//     );
//     ;
//   }
// }
