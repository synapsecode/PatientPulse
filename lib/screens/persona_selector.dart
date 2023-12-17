import 'package:flutter/material.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/screens/doctor/doctor_login.dart';
import 'package:patientpulse/screens/patient/patient_login.dart';

class PersonaSelector extends StatelessWidget {
  const PersonaSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 47, 82),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
                  'https://static.vecteezy.com/system/resources/previews/015/309/493/original/heart-rate-pulse-icon-medicine-logo-heartbeat-heart-rate-icon-audio-sound-radio-wave-amplitude-spikes-free-png.png')
              .limitSize(300),
          Text('Patient Pulse')
              .color(Colors.white)
              .size(42)
              .weight(FontWeight.w200),
          Text('Medical data tracking made easy!')
              .color(Colors.white)
              .weight(FontWeight.w300),
          SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              Navigator.of(context).replaceWithNewPage(DoctorLoginScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  color: Colors.red.withAlpha(150),
                  borderRadius: BorderRadius.circular(3)),
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Doctor')
                  .color(Colors.white)
                  .size(24)
                  .weight(FontWeight.w200)
                  .center(),
            ),
          ).addBottomMargin(20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).replaceWithNewPage(PatientLoginScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  color: Colors.red.withAlpha(150),
                  borderRadius: BorderRadius.circular(3)),
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Patient')
                  .color(Colors.white)
                  .size(24)
                  .weight(FontWeight.w200)
                  .center(),
            ),
          ).addBottomMargin(20),
          Text('Made by Team Coaders').color(Colors.white24),
        ],
      ).center(),
    );
  }
}
