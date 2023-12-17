import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/main.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        title: Text('PatientPulse (admin)').color(Colors.white),
        centerTitle: true,
        actions: [
          Icons.logout.toIcon(color: Colors.white).onClick(() async {
            await HSPatient.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => PatientPulseWrapper()),
              (route) => false,
            );
          }).addRightMargin(20)
        ],
      ),
    );
  }
}
