import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/models/vital.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/main.dart';
import 'package:patientpulse/screens/components.dart';

class AddVitalsPage extends StatefulWidget {
  const AddVitalsPage({super.key});

  @override
  State<AddVitalsPage> createState() => _AddVitalsPageState();
}

class _AddVitalsPageState extends State<AddVitalsPage> {
  Map<String, TextEditingController> tcList = {};

  @override
  void initState() {
    loadVitals();
    super.initState();
  }

  List vitals = [];
  bool loading = false;

  loadVitals() async {
    final aP = gpc.read(activePatient);
    setState(() {
      loading = true;
    });
    vitals = [...await HSPatient.getVitals(aP!.patientEId)];
    for (final v in vitals) {
      tcList[v.code] = TextEditingController(text: v.value ?? '');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ).center();
    }
    return Column(
      children: [
        Image.network('https://img.icons8.com/fluency/128/pulse-oximeter.png')
            .center()
            .addTopMargin(20)
            .addBottomMargin(20),
        Text(
          'Update Vitals',
          style: TextStyle(height: 0.99),
        ).color(Colors.amber).size(40).align(TextAlign.center),
        Text('Patient: ${gpc.read(activePatient)!.patientName}')
            .color(Colors.white54)
            .addTopMargin(10),
        SizedBox(height: 20),
        Container(
          height: 300,
          color: Colors.white.withAlpha(10),
          child: ListView.builder(
            itemCount: vitals.length,
            itemBuilder: (context, i) {
              final v = vitals[i];
              return ListTile(
                leading: Icons.info.toIcon(color: Colors.white),
                title: Text(v.name).color(Colors.amber),
                trailing: Row(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: tcList[v.code],
                    ).expanded(),
                    SizedBox(width: 10),
                    Text(v.unit),
                  ],
                ).limitSize(130),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: update,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent),
              color: Colors.red.withAlpha(150),
              borderRadius: BorderRadius.circular(3),
            ),
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Update')
                .color(Colors.white)
                .size(24)
                .weight(FontWeight.w200)
                .center(),
          ),
        ).addTopMargin(20),
      ],
    );
  }

  update() async {
    final patient = gpc.read(activePatient);
    final List x = [];
    for (final v in vitals) {
      final val = tcList[v.code]!.value.text;
      v.value = val;
      x.add(v);
    }
    await HSAdmin.updateVitals(vitals: x, patient: patient!);
    Fluttertoast.showToast(msg: 'Vitals Updated!');
    tcList.clear();
    vitals.clear();
    loadVitals();
  }
}
