import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';

class PatientPulsePlayground extends ConsumerWidget {
  const PatientPulsePlayground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cAdmin = ref.watch(currentAdmin);
    final cPat = ref.watch(currentPatient);
    final aT = ref.watch(bearerTokenProvider);
    final acP = ref.watch(activePatient);

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
            Text(aT.toString()).size(12).addTopMargin(10),
            SizedBox(height: 10),
            Text('Current Patient'),
            Text(cPat?.patientName ?? 'No Patient').size(40),
            Text((acP?.patientEId).toString()).size(12),
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
            Text('Patient Functions').size(30).addTopMargin(10),
            ElevatedButton(
              onPressed: () async {
                final vitals = await HSPatient.getVitals();
                for (final v in vitals) {
                  print("${v.name}: ${v.value} ${v.unit}");
                }
              },
              child: Text('Check My Vitals'),
            ),
            ElevatedButton(
              onPressed: () async {
                final medications = await HSPatient.getMyMedications();
                for (final m in medications) {
                  print("${m.brandName} ${m.dosage}");
                }
              },
              child: Text('Check Medications'),
            ),
            ElevatedButton(
              onPressed: () async {
                final history = await HSPatient.getHistory();
                for (final h in history) {
                  print("${h.title} | ${h.message} | ${h.date}");
                }
              },
              child: Text('Check My History'),
            ),
            SizedBox(height: 20),
            Text('Admin(Doctor) Functions')
                .size(30)
                .addTopMargin(10)
                .addBottomMargin(10),
            ElevatedButton(
              onPressed: () async {
                final deps = await HSAdmin.getAllDepartments();
                for (final d in deps) {
                  print(d.name);
                }
              },
              child: Text('Get All Departments'),
            ),
            ElevatedButton(
              onPressed: () async {
                final visits = await HSAdmin.getAllActiveVisits();
                for (final p in visits) {
                  print(p.nameAlias);
                }
              },
              child: Text('View Active Visits'),
            ),
            ElevatedButton(
              onPressed: () async {
                HSAdmin.checkinPatient('Alice Banks');
              },
              child: Text('Checkin Patient'),
            ),
            ElevatedButton(
              onPressed: () async {
                HSAdmin.checkoutPatient();
              },
              child: Text('Checkout Patient'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (acP == null) return print('ACP is null');
                final vitals = await HSPatient.getVitals(acP.patientEId);
                for (final v in vitals) {
                  print("${v.name}: ${v.value} ${v.unit}");
                }
              },
              child: Text('Check Patient Vitals'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (acP == null) return print('ACP is null');
                await HSAdmin.prescribeMedication(
                  start: DateTime.now().add(Duration(days: 1)),
                  end: DateTime.now().add(Duration(days: 8)),
                  brandName: 'Salazar',
                  dosage: '150mg',
                  freq: ('2', '2', '1'),
                );
              },
              child: Text('Prescribe Medication'),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
