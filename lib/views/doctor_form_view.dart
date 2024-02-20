import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fypapp/components/tooltip.dart';
import 'package:fypapp/models/hospital_model.dart';
import 'package:provider/provider.dart';
import '../providers/hospital_provider.dart';

class DoctorFormView extends StatefulWidget {
  const DoctorFormView({Key? key}) : super(key: key);

  @override
  DoctorFormViewState createState() => DoctorFormViewState();
}

class DoctorFormViewState extends State<DoctorFormView> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String regNumber;
  late String specialization;
  late DocumentReference hospitalId;
  late String hospitalName;
  late String availability;
  late String dutyStartTime = 'Not selected';
  late String dutyEndTime = 'Not selected';
  late String selectedHospital = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Form'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<HospitalModel>>(
        future: context.read<HospitalProvider>().getHospitals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return _buildForm(snapshot.data!);
            } else if (snapshot.hasError){
              return Center(child: Text('error is ${snapshot.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          }
        },
      ),
    );
  }

  Widget _buildForm(List<HospitalModel> hospitals) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Medical License Registration No.',
                  border: const OutlineInputBorder(),
                  suffixIcon: buildTooltip('Enter your Medical License Registration Number')
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your registration number';
                  }
                  return null;
                },
                onSaved: (value) {
                  regNumber = value!;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Specialization(s)',
                  border: const OutlineInputBorder(),
                  suffixIcon: buildTooltip('E.g. Cardiologist, Neurologist, General Physician etc.'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your specialization(s)';
                  }
                  return null;
                },
                onSaved: (value) {
                  specialization = value!;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Availability',
                  border: const OutlineInputBorder(),
                  suffixIcon: buildTooltip('E.g. Monday to Wednesday, Weekends only etc.')
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your availability days';
                  }
                  return null;
                },
                onSaved: (value) {
                  availability = value!;
                },
              ),
              const SizedBox(height: 10,),
              DropdownButtonFormField<HospitalModel>(
                hint: const Text('Select Hospital'),
                value: selectedHospital.isNotEmpty ? hospitals.firstWhere((hospital) => hospital.name == selectedHospital) : null,
                items: hospitals.map((HospitalModel hospital) {
                  return DropdownMenuItem<HospitalModel>(
                    value: hospital,
                    child: Text(hospital.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedHospital = newValue!.name;
                    hospitalId = 'hopitals/${newValue.id}' as DocumentReference;
                  });
                },
                validator: (value) {
                  if (value == null || value.name.isEmpty) {
                    return 'Please select a hospital';
                  }
                  return null;
                },
                onSaved: (value) {
                  hospitalName = value!.name;
                  hospitalId = 'hopitals/${value.id}' as DocumentReference;
                },
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Duty Start Time: $dutyStartTime'),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            dutyStartTime = picked.format(context);
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Duty End Time: $dutyEndTime'),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            dutyEndTime = picked.format(context);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async {
                  print('hopitals/$hospitalId');
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('hopitals/$hospitalName');

                    // await DocDatabaseHelper().updateDoctor(_doctor);
                    // Navigate to the next page or show a success message
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
