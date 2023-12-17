import 'package:flutter/material.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/main.dart';
import 'package:patientpulse/screens/doctor/doctor_home.dart';
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
      backgroundColor: Color.fromARGB(255, 2, 22, 38),
      appBar: AppBar(
        title: Text("Patient Checkin").color(Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://img.icons8.com/fluency/96/enter-2.png'),
            Text('Check-In Patient').color(Colors.white).size(40),
            SizedBox(height: 20),
            TextField(
              controller: pNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'full name',
                labelStyle: TextStyle(color: Colors.amber.withAlpha(100)),
                border: OutlineInputBorder(),
              ),
            ).addHorizontalMargin(20),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
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
                Navigator.of(context).replaceWithNewPage(DoctorHome());
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
                child: Text('Check-In')
                    .color(Colors.white)
                    .size(24)
                    .weight(FontWeight.w200)
                    .center(),
              ),
            ).addBottomMargin(20),
            Text('Logout').color(Colors.white30).size(20).onClick(() {
              HSAdmin.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => PatientPulseWrapper()),
                (route) => false,
              );
            })
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
