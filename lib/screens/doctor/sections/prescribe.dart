import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/main.dart';
import 'package:patientpulse/screens/components.dart';

class PrescribePage extends StatefulWidget {
  const PrescribePage({super.key});

  @override
  State<PrescribePage> createState() => _PrescribePageState();
}

class _PrescribePageState extends State<PrescribePage> {
  DateTime? sD;
  DateTime? eD;
  TextEditingController dnC = TextEditingController();
  TextEditingController dosC = TextEditingController();
  TextEditingController freqC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network('https://img.icons8.com/emoji/128/pill-emoji.png')
            .center()
            .addTopMargin(20)
            .addBottomMargin(20),
        Text(
          'Prescribe Medication',
          style: TextStyle(height: 0.99),
        ).color(Colors.amber).size(40).align(TextAlign.center),
        Text('Patient: ${gpc.read(activePatient)!.patientName}')
            .color(Colors.white54)
            .addTopMargin(10),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Text(sD != null ? sD!.getDateString() : 'course start')
                  .color(Colors.white54)
                  .center(),
            ).onClick(() {
              selectDate(context);
            }),
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Text(eD != null ? eD!.getDateString() : 'course end')
                  .color(Colors.white54)
                  .center(),
            ).onClick(() {
              selectDate(context, start: false);
            }),
          ],
        ).addHorizontalMargin(10),
        TextField(
          controller: dnC,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'drug name (eg. Dolo650)',
            labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
            border: OutlineInputBorder(),
          ),
        ).addHorizontalMargin(16).addTopMargin(10),
        TextField(
          controller: dosC,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'dosage (eg. 50mg)',
            labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
            border: OutlineInputBorder(),
          ),
        ).addHorizontalMargin(16).addTopMargin(10),
        TextField(
          controller: freqC,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'frequency',
            labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
            border: OutlineInputBorder(),
          ),
        ).addHorizontalMargin(16).addTopMargin(10),
        GestureDetector(
          onTap: () async {
            if (sD == null || eD == null) return;
            final freq = freqC.value.text.split('-');
            await HSAdmin.prescribeMedication(
              start: sD!,
              end: eD!,
              brandName: dnC.value.text,
              dosage: dosC.value.text,
              freq: (freq[0], freq[1], freq[2]),
            );
            await Fluttertoast.showToast(
              msg: "Medication Prescribed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            dnC.clear();
            dosC.clear();
            freqC.clear();
            sD = eD = null;
            setState(() {});
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
            child: Text('Prescribe')
                .color(Colors.white)
                .size(24)
                .weight(FontWeight.w200)
                .center(),
          ),
        ).addTopMargin(20),
      ],
    );
  }

  Future<void> selectDate(BuildContext context, {bool start = true}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: sD != null ? sD! : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      if (start) {
        setState(() {
          sD = picked;
        });
      } else {
        setState(() {
          eD = picked;
        });
      }
    }
  }
}
