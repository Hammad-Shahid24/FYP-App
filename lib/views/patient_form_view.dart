
import 'package:flutter/material.dart';
import 'package:fypapp/constants/routes.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:provider/provider.dart';

import '../models/patient_model.dart';
import '../providers/patient_provider.dart';

class PatientFormView extends StatefulWidget {
  const PatientFormView({super.key});

  @override
  _PatientFormViewState createState() => _PatientFormViewState();
}

class _PatientFormViewState extends State<PatientFormView> {
  final _formKey = GlobalKey<FormState>();

  late String _displayName;
  late String _firstName;
  late String _lastName;
  late int _age;
  late String _gender;
  late String _phoneNumber;
  static const List<String> _genders = ['Male', 'Female', 'Others'];
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Form'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Styling the TextFormField with InputDecoration
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _displayName = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                value: _selectedGender,
                items: _genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value.toString();
                  });
                },
                onSaved: (value) {
                  _gender = value.toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length != 11) {
                    return 'Please enter your 11 character phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Create a PatientModel object with the entered values
                    PatientModel patient = PatientModel(
                      id: await SharedPreferencesService.start().getUserId,
                      displayName: _displayName,
                      firstName: _firstName,
                      lastName: _lastName,
                      age: _age,
                      gender: _gender,
                      isVerified: false,
                      // Assuming not verified initially
                      createdAt: DateTime.now(),
                      // Assuming using Firestore Timestamp
                      updatedAt: DateTime.now(),
                      imei: '',
                      phoneNumber: _phoneNumber,
                    );
                    context.read<PatientProvider>().updatePatient(patient);
                    SharedPreferencesService.start().saveIsFormFilled(true);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        patientHomeRoute, (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // foreground
                ),
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(DateTime.now());
                },
                child: const Text('please work'),
              )
              // ElevatedButton(
              //     onPressed: () async {
              //       // if (Theme.of(context).platform == TargetPlatform.android) {
              //       //   AndroidDeviceInfo androidInfo =
              //       //   await DeviceInfoPlugin().androidInfo;
              //       //   final imei = androidInfo.id;
              //       //   print('IMEI: $imei');
              //       // } else {
              //       //   print('IMEI not available on iOS or other platforms');
              //       // }
              //     },
              //     child: const Text('imei'))
            ],
          ),
        ),
      ),
    );
  }
}
