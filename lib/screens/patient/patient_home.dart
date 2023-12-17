import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/main.dart';
import 'package:patientpulse/screens/patient/sections/myassessments.dart';
import 'package:patientpulse/screens/patient/sections/myhistory.dart';
import 'package:patientpulse/screens/patient/sections/mymedications.dart';
import 'package:patientpulse/screens/patient/sections/myvitals.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 22, 38),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        child: Column(
          children: [
            Image.network(
                'https://static.vecteezy.com/system/resources/previews/015/309/493/original/heart-rate-pulse-icon-medicine-logo-heartbeat-heart-rate-icon-audio-sound-radio-wave-amplitude-spikes-free-png.png'),
            SizedBox(height: 40),
            ListTile(
              leading: Icons.list_alt.toIcon(color: Colors.white),
              title: Text('About').color(Colors.white),
              subtitle: Text('about the app').color(Colors.white60),
              onTap: () {},
            ).translate(0, -40, 0),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        title: Text('PatientPulse').color(Colors.white),
        centerTitle: true,
        actions: [
          Icons.logout.toIcon(color: Colors.white).onClick(() async {
            await HSPatient.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => PatientPulseWrapper()),
              (route) => false,
            );
          }).addRightMargin(20)
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: IndexedStack(
            index: pageIndex,
            children: [
              MyVitalsPage(),
              MyMedicationsPage(),
              MyHistoryPage(),
              MyAssessmentsPage(),
            ],
          )),
      bottomNavigationBar: GNav(
        selectedIndex: pageIndex,
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(255, 9, 72, 123),
        onTabChange: (i) {
          pageIndex = i;
          setState(() {
            pageIndex = i;
          });
        },
        gap: 7,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(5),
        tabs: const [
          GButton(icon: Icons.favorite, text: 'Vitals'),
          GButton(icon: Icons.medication_rounded, text: 'Medications'),
          GButton(icon: Icons.history, text: 'Visit History'),
          GButton(icon: Icons.history, text: 'Assessment'),
        ],
      ),
    );
  }
}
