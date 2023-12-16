import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';

final gpc = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(Duration(milliseconds: 200), () {
    HSPatient.tryAutoLogin();
  });
  runApp(UncontrolledProviderScope(
    container: gpc,
    child: const PatientPulseApp(),
  ));
}

class PatientPulseApp extends StatelessWidget {
  const PatientPulseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Patient Pulse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PatientPulseWrapper(),
      ),
    );
  }
}

class PatientPulseWrapper extends StatelessWidget {
  const PatientPulseWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Pulse'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              HSAdmin.login('8660033751', '0000');
            },
            child: Text('Test Login'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  HSPatient.login('manashejmadi', '12345');
                },
                child: Text('Test Login for Patient'),
              ),
              ElevatedButton(
                onPressed: () {
                  HSPatient.logout();
                },
                child: Text('Test Logout for Patient'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
