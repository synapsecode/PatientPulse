import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:patientpulse/backend/models/history.dart';
import 'package:patientpulse/backend/models/medication.dart';
import 'package:patientpulse/backend/models/vital.dart';
import 'package:patientpulse/extensions/extensions.dart';

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
          Text(model.name)
              .color(model.value == '-'
                  ? Colors.grey
                  : Colors.redAccent.withAlpha(200))
              .size(30),
          if (model.value == '-') ...[
            Text('Not Applicable').color(Colors.white24).size(22)
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(model.value!).color(Colors.amber).size(40),
                Text(model.unit)
                    .color(Colors.white30)
                    .size(32)
                    .addLeftMargin(5),
              ],
            ),
            Row(
              children: [
                Text("Date Added: ${model.checkedDate?.getDateString() ?? 'unavailable'}")
                    .color(Colors.white38),
                Expanded(child: Container()),
                Text('Check Trend')
                    .color(Colors.orange.withAlpha(220))
                    .addRightMargin(10),
              ],
            ),
          ],
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
      color: Color.fromARGB(255, 5, 47, 82),
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title).color(Colors.amberAccent).size(40),
            Text(model.date?.getDateString() ?? 'unspecified')
                .color(Colors.amber),
            SizedBox(height: 8.0),
            HtmlWidget(
              model.message,
              textStyle: TextStyle(color: Colors.white70),
            ),
            // Text(
            //   model.message,
            //   style: TextStyle(fontSize: 16.0),
            // ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class MedicationDisplayElement extends StatelessWidget {
  final MedicationModel model;

  MedicationDisplayElement({required this.model});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: model.isActive ? 1 : 0.4,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network('https://img.icons8.com/emoji/48/pill-emoji.png'),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: model.brandName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              )),
                          TextSpan(
                              text: model.dosage.isEmpty
                                  ? " (50mg)"
                                  : " (${model.dosage})",
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 25,
                              ))
                        ],
                      ),
                    ).limitSize(220),
                    Text('${model.frequency.$1}-${model.frequency.$2}-${model.frequency.$3}')
                        .color(Colors.amber.withAlpha(200))
                        .addTopMargin(2),
                  ],
                ),
              ],
            ).addBottomMargin(10),
            Text('Start Date: ${model.courseDuration.start.getDateString()}')
                .color(Colors.white38),
            Text('End Date: ${model.courseDuration.end.getDateString()}')
                .color(Colors.white38),
          ],
        ),
      ),
    );
  }
}
