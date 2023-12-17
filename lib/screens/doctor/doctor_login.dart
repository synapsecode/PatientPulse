import 'package:flutter/material.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/screens/doctor/doctor_home.dart';
import 'package:patientpulse/screens/patient/patient_home.dart';
import 'package:patientpulse/utils.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  TextEditingController uC = TextEditingController();
  TextEditingController mpinC = TextEditingController();

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
                    'https://img.icons8.com/color/512/doctor-male-skin-type-3.png')
                .limitSize(150)
                .addBottomMargin(20),
            Text('Doctor Login')
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
              controller: mpinC,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mpin',
                labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
                border: OutlineInputBorder(),
              ),
            ).addHorizontalMargin(20).addBottomMargin(10),
            GestureDetector(
              onTap: () async {
                final uname = uC.value.text.trim();
                final pwd = mpinC.value.text.trim();
                final res = await HSAdmin.login(uname, pwd);
                if (!res) {
                  return await CustomDialogs.showDefaultAlertDialog(
                    context,
                    contentTitle: 'Unable to Login',
                    contentText:
                        'either an error occured or your credentials are incorrect',
                  );
                }
                Navigator.of(context).replaceWithNewPage(DoctorHome());
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
