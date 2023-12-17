import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/screens/patient/patient_home.dart';
import 'package:patientpulse/utils.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  TextEditingController uC = TextEditingController();
  TextEditingController pC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 47, 82),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height:
                    MediaQuery.of(context).viewInsets.bottom != 0 ? 50 : 100),
            Image.network(
                    'https://img.icons8.com/fluency/512/000000/login-rounded-right.png')
                .limitSize(150)
                .addBottomMargin(20),
            Text('Patient Login')
                .color(Colors.white)
                .size(42)
                .weight(FontWeight.w200),
            Text('please Login to access the app')
                .color(Colors.white)
                .weight(FontWeight.w300),
            SizedBox(height: 40),
            TextField(
              controller: uC,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'username',
                labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
                border: OutlineInputBorder(),
              ),
            ).addHorizontalMargin(20).addBottomMargin(10),
            TextField(
              controller: pC,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'password',
                labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
                border: OutlineInputBorder(),
              ),
            ).addHorizontalMargin(20).addBottomMargin(10),
            GestureDetector(
              onTap: () async {
                final uname = uC.value.text.trim();
                final pwd = pC.value.text.trim();
                final res = await HSPatient.login(uname, pwd);
                if (!res) {
                  return await CustomDialogs.showDefaultAlertDialog(
                    context,
                    contentTitle: 'Unable to Login',
                    contentText:
                        'either an error occured or your credentials are incorrect',
                  );
                }
                Navigator.of(context).replaceWithNewPage(PatientHome());
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  color: Colors.red.withAlpha(150),
                  borderRadius: BorderRadius.circular(3),
                ),
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Login')
                    .color(Colors.white)
                    .size(24)
                    .weight(FontWeight.w200)
                    .center(),
              ),
            ).addBottomMargin(20),
            Text('Made by Team Coaders').color(Colors.white24),
            SizedBox(height: 50),
          ],
        ).center(),
      ),
    );
  }
}
