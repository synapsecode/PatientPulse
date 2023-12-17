import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/screens/components.dart';

class MyAssessmentsPage extends StatefulWidget {
  const MyAssessmentsPage({super.key});

  @override
  State<MyAssessmentsPage> createState() => _MyVitalsPageState();
}

class _MyVitalsPageState extends State<MyAssessmentsPage> {
  @override
  void initState() {
    loadMedications();
    super.initState();
  }

  List assessments = [];
  bool loading = false;

  loadMedications() async {
    setState(() {
      loading = true;
    });
    assessments = [];
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        Image.network(
            'https://img.icons8.com/pulsar-color/512/coming-soon.png'),
        Text('Assessment').color(Colors.white).size(40).align(TextAlign.center),
        Text('feature coming soon')
            .color(Colors.white30)
            .size(20)
            .translate(0, -10, 0),
      ],
    ).center();
  }
}
