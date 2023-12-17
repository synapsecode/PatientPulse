import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/models/patient.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/playground.dart';
import 'package:patientpulse/screens/doctor/checklin.dart';
import 'package:patientpulse/screens/doctor/doctor_home.dart';
import 'package:patientpulse/screens/patient/patient_home.dart';
import 'package:patientpulse/screens/persona_selector.dart';

final gpc = ProviderContainer();
final navigatorKey = GlobalKey<NavigatorState>();

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
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
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

class PatientPulseWrapper extends ConsumerStatefulWidget {
  const PatientPulseWrapper({super.key});

  @override
  ConsumerState<PatientPulseWrapper> createState() =>
      _PatientPulseWrapperState();
}

class _PatientPulseWrapperState extends ConsumerState<PatientPulseWrapper> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      handleRedirect();
    });

    super.initState();
  }

  handleRedirect() {
    final cPat = ref.watch(currentPatient);
    final cAdmin = ref.watch(currentAdmin);

    if (cAdmin != null) {
      //Redireect to AdminHome
      Navigator.of(context).replaceWithNewPage(DoctorHome());
    } else if (cPat != null) {
      //Redirect to Patient Home
      Navigator.of(context).replaceWithNewPage(PatientHome());
    }
  }

  @override
  Widget build(BuildContext context) {
    // return PatientPulsePlayground();
    return PersonaSelector();
  }
}
