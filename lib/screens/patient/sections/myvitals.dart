import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/screens/components.dart';

class MyVitalsPage extends StatefulWidget {
  const MyVitalsPage({super.key});

  @override
  State<MyVitalsPage> createState() => _MyVitalsPageState();
}

class _MyVitalsPageState extends State<MyVitalsPage> {
  @override
  void initState() {
    loadVitals();
    super.initState();
  }

  List vitals = [];
  bool loading = false;

  loadVitals() async {
    setState(() {
      loading = true;
    });
    vitals = [...await HSPatient.getVitals()];
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
    return (vitals.isEmpty)
        ? Text('nothing to see here').color(Colors.white30).center()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: vitals.length,
              itemBuilder: (context, i) {
                final v = vitals[i];
                return VitalDisplayElement(model: v);
              },
            ).addBottomMargin(200),
          );
  }
}
