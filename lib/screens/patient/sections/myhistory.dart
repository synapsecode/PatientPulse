import 'package:flutter/material.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/extensions/miscextensions.dart';
import 'package:patientpulse/screens/components.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({super.key});

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  List history = [];
  bool loading = false;

  loadHistory() async {
    setState(() {
      loading = true;
    });
    history = [...await HSPatient.getHistory()];
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
    return (history.isEmpty)
        ? Text('nothing to see here').color(Colors.white30).center()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final h = history[i];
                return ProgressHistoryElement(model: h);
              },
            ).addBottomMargin(200),
          );
  }
}
