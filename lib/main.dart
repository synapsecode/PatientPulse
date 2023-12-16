import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/models/patient.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/playground.dart';
import 'package:patientpulse/screens/doctor/patient_checkin.dart';
import 'package:patientpulse/screens/persona_selector.dart';

final gpc = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(Duration(milliseconds: 200), () {
    HSPatient.tryAutoLogin();
    HSAdmin.tryAutoLogin();
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
    // return PatientPulsePlayground();
    return PersonaSelector();
  }
}
