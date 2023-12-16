import 'package:flutter/material.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/utils.dart';

class CheckinPatientPage extends StatefulWidget {
  const CheckinPatientPage({super.key});

  @override
  State<CheckinPatientPage> createState() => _CheckinPatientPageState();
}

class _CheckinPatientPageState extends State<CheckinPatientPage> {
  TextEditingController pNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Patient's Full Name").color(Colors.white),
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pNameController,
              decoration: InputDecoration(
                labelText: 'Patient Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                ),
              ),
              onPressed: () async {
                final fn = pNameController.value.text.trim();
                final res = await HSAdmin.checkinPatient(fn);
                if (!res) {
                  return await CustomDialogs.showDefaultAlertDialog(
                    context,
                    contentTitle: 'CheckIn Error',
                    contentText: 'unable to check-in this user',
                  );
                }
                print('Patient Checked in!');
              },
              child: Text('Check-In Patient'),
            ),
          ],
        ),
      ),
    );
  }
}

// class PatientListPage extends StatelessWidget {
//   final int patientId;

//   const PatientListPage(this.patientId);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 181, 214, 240),
//         title: Text('Patient List'),
//       ),
//       body: ListView.builder(
//         itemCount: patients.length,
//         itemBuilder: (context, index) {
//           return PatientCard(
//             name: patients[index].name,
//             reasonForVisit: patients[index].reasonForVisit,
//           );
//         },
//       ),
//     );
//   }
// }

// class PatientCard extends StatelessWidget {
//   final String name;
//   final String reasonForVisit;

//   PatientCard({required this.name, required this.reasonForVisit});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8.0),
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Name: $name',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//                 // color: Theme.of(context).primaryColor,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               'Reason for Visit: $reasonForVisit',
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
