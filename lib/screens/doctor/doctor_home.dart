import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';
import 'package:patientpulse/main.dart';
import 'package:patientpulse/screens/doctor/checklin.dart';
import 'package:patientpulse/screens/doctor/departments_list.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int pageIndex = 0;

  Widget getPageContent() {
    return FlutterLogo();
  }

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
              title: Text('Departments').color(Colors.white),
              subtitle: Text('seee all departments').color(Colors.white60),
              onTap: () {
                Navigator.of(context).pushNewPage(DepartmentsList());
              },
            ).translate(0, -40, 0),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        title: Text('PatientPulse (admin)').color(Colors.white),
        centerTitle: true,
        actions: [
          Icons.logout.toIcon(color: Colors.white).onClick(() async {
            gpc.read(activePatient.notifier).state = null;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CheckinPatientPage()),
              (route) => false,
            );
          }).addRightMargin(20)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: getPageContent(),
      ),
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
          GButton(icon: Icons.edit, text: 'Prescribe'),
          GButton(icon: Icons.event, text: 'Visits'),
          GButton(icon: Icons.list_alt, text: 'Departments'),
        ],
      ),
    );
  }
}
