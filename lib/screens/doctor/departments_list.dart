import 'package:flutter/material.dart';
import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/extensions/extensions.dart';

class DepartmentsList extends StatefulWidget {
  const DepartmentsList({super.key});

  @override
  State<DepartmentsList> createState() => _DepartmentsListState();
}

class _DepartmentsListState extends State<DepartmentsList> {
  List departments = [];
  bool loading = false;

  loadDepartments() async {
    setState(() {
      loading = true;
    });
    departments = [...await HSAdmin.getAllDepartments()];
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loadDepartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 22, 38),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 47, 82),
        title: Text('All Departments').color(Colors.white),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: loading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ).center()
          : ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, i) {
                final dep = departments[i];
                return ListTile(
                  title: Text(dep.name).color(Colors.white),
                );
              },
            ),
    );
  }
}
