import 'package:flutter/material.dart';
import 'package:patientpulse/backend/models/history.dart';
import 'package:patientpulse/backend/models/medication.dart';
import 'package:patientpulse/backend/models/vital.dart';

class VitalDisplayElement extends StatelessWidget {
  final VitalModel model;

  const VitalDisplayElement({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vital Name: ${model.name}'),
          Text('Vital Value: ${model.value} ${model.unit}'),
        ],
      ),
    );
  }
}

class ProgressHistoryElement extends StatelessWidget {
  final ProgressHistory model;

  const ProgressHistoryElement({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              model.message,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              "Date: ${model.date}",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicationDisplayElement extends StatelessWidget {
  final MedicationModel medication;

  MedicationDisplayElement({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Medicine Name: ${medication.brandName}'),
          Text('Start Date: ${medication.courseDuration.start}'),
          Text('End Date: ${medication.courseDuration.end}'),
          Text('Dosage: ${medication.dosage}'),
          Text('Frequency: ${medication.frequency}'),
        ],
      ),
    );
  }
}
