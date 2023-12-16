import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';

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

class PatientPulseWrapper extends ConsumerWidget {
  const PatientPulseWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cAdmin = ref.watch(currentAdmin);
    final cPat = ref.watch(currentPatient);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Pulse'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Admin'),
            Text(cAdmin?.eid ?? 'No Admin').size(40),
            SizedBox(height: 10),
            Text('Current Patient'),
            Text(cPat?.patientName ?? 'No Patient').size(40),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    HSAdmin.login('8660033751', '0000');
                  },
                  child: Text('Doctor Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    HSAdmin.logout();
                  },
                  child: Text('Doctor Logout'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    HSPatient.login('manashejmadi', '12345');
                  },
                  child: Text('Patient Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    HSPatient.logout();
                  },
                  child: Text('Patient Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
