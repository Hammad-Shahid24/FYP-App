import 'package:flutter/material.dart';
import 'package:fypapp/components/tooltip.dart';
import 'package:fypapp/models/doctor_model.dart';
import 'package:fypapp/models/hospital_model.dart';
import 'package:fypapp/providers/doc_provider.dart';
import 'package:fypapp/services/shared_preferences/sp_service.dart';
import 'package:provider/provider.dart';
import '../constants/routes.dart';
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
  late String hospitalId;
  late String hospitalName;
  late String availability;
  late String selectedHospital = '';

  late TextEditingController _nameController;
  late TextEditingController _regNumberController;
  late TextEditingController _specializationController;
  late TextEditingController _availabilityController;

  TimeOfDay? dutyStart;
  TimeOfDay? dutyEnd;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _regNumberController = TextEditingController();
    _specializationController = TextEditingController();
    _availabilityController = TextEditingController();
  }

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
            } else if (snapshot.hasError) {
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _nameController,
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _regNumberController,
                decoration: InputDecoration(
                    hintText: 'Medical License Registration No.',
                    border: const OutlineInputBorder(),
                    suffixIcon: buildTooltip(
                        'Enter your Medical License Registration Number')),
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _specializationController,
                decoration: InputDecoration(
                  hintText: 'Specialization(s)',
                  border: const OutlineInputBorder(),
                  suffixIcon: buildTooltip(
                      'E.g. Cardiologist, Neurologist, General Physician etc.'),
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _availabilityController,
                decoration: InputDecoration(
                    hintText: 'Availability',
                    border: const OutlineInputBorder(),
                    suffixIcon: buildTooltip(
                        'E.g. Monday to Wednesday, Weekends only etc.')),
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
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<HospitalModel>(
                hint: const Text('Select Hospital'),
                value: selectedHospital.isNotEmpty
                    ? hospitals.firstWhere(
                        (hospital) => hospital.name == selectedHospital)
                    : null,
                items: hospitals.map((HospitalModel hospital) {
                  return DropdownMenuItem<HospitalModel>(
                    value: hospital,
                    child: Text(hospital.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedHospital = newValue!.name;
                    hospitalId = 'hospitals/${newValue.id}';
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
                  hospitalId = 'hospitals/${value.id}';
                },
              ),
              const SizedBox(
                height: 10,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Duty Start Time: $dutyStart'),
                  onTap: () async {
                    final TimeOfDay? picker = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picker != null && picker != dutyStart) {
                      setState(() {
                        dutyStart = picker;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Duty End Time: $dutyEnd'),
                  onTap: () async {
                    final TimeOfDay? picker = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picker != null && picker != dutyEnd) {
                      setState(() {
                        dutyEnd = picker;
                      });
                    }
                  },
                ),
              ),
            ]
          ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (dutyStart == null || dutyEnd == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select duty start and end time'),
                      ),
                    );
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await context.read<DocProvider>().updateDoctor(
                          DoctorModel(
                            id: await SharedPreferencesService().getUserId
                            as String,
                            name: name,
                            regNumber: regNumber,
                            specialization: specialization,
                            hospitalId: hospitalId,
                            hospitalName: selectedHospital,
                            availability: availability,
                            dutyStartTime: dutyStart.toString(),
                            dutyEndTime: dutyEnd.toString(),
                          ));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          doctorHomeRoute, (route) => false);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                        ),
                      );
                    }
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
