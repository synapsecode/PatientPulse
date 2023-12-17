import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/screens/components.dart';

class ActiveVisitsPage extends StatefulWidget {
  const ActiveVisitsPage({super.key});

  @override
  State<ActiveVisitsPage> createState() => _ActiveVisitsPageState();
}

class _ActiveVisitsPageState extends State<ActiveVisitsPage> {
  @override
  void initState() {
    loadVisits();
    super.initState();
  }

  List visits = [];
  bool loading = false;

  loadVisits() async {
    setState(() {
      loading = true;
    });
    visits = [...await HSAdmin.getAllActiveVisits()];
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
    return (visits.isEmpty)
        ? Text('nothing to see here').color(Colors.white30).center()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: visits.length,
              itemBuilder: (context, i) {
                final p = visits[i];
                return ListTile(
                  tileColor: Color.fromARGB(255, 5, 47, 82),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/color/96/patient-oxygen-mask.png'),
                  ),
                  title: Text(p.nameAlias).color(Colors.amber).size(20),
                  subtitle: Text(reasons[Random().nextInt(reasons.length)])
                      .color(Colors.white30),
                );
              },
            ).addBottomMargin(200),
          );
  }
}

List<String> reasons = [
  'insomnia',
  'stomach ulcer',
  'heartburn',
  'chest congestion',
  'high-grade fever'
];
