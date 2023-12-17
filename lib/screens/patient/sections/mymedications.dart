import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/screens/components.dart';

class MyMedicationsPage extends StatefulWidget {
  const MyMedicationsPage({super.key});

  @override
  State<MyMedicationsPage> createState() => _MyVitalsPageState();
}

class _MyVitalsPageState extends State<MyMedicationsPage> {
  @override
  void initState() {
    loadMedications();
    super.initState();
  }

  List medications = [];
  bool loading = false;

  loadMedications() async {
    setState(() {
      loading = true;
    });
    medications = [...await HSPatient.getMyMedications()];
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
    return (medications.isEmpty)
        ? Text('nothing to see here').color(Colors.white30).center()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: medications.length,
              itemBuilder: (context, i) {
                final m = medications[i];
                return MedicationDisplayElement(model: m);
              },
            ),
          );
  }
}
