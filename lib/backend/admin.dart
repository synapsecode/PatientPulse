import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/dioexecutor.dart';
import 'package:patientpulse/backend/healthscore.dart';
import 'package:patientpulse/backend/models/admin.dart';
import 'package:patientpulse/backend/models/department.dart';
import 'package:patientpulse/backend/models/medication.dart';
import 'package:patientpulse/backend/models/patient.dart';
import 'package:patientpulse/backend/utils.dart';
import 'package:patientpulse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currentPatient = StateProvider<PatientModel?>((ref) => null);
final currentAdmin = StateProvider<AdminModel?>((ref) => null);

class HSAdmin {
  static Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await DioExecutor.get(
      url: HSCreds.getLoginURL(username: username, password: password),
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, null);
    }
    final admin = AdminModel.fromMap(res.$1!);
    gpc.read(currentAdmin.notifier).state = admin;
    print('SavingPatientExtract => ${admin.serialize()}');
    await prefs.setString('loggedin_admin', admin.serialize());
  }

  static logout() async {
    final prefs = await SharedPreferences.getInstance();
    gpc.read(currentAdmin.notifier).state = null;
    await prefs.remove('loggedin_admin');
    print('Logged Out from Admin');
  }

  static tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final laSerialized = prefs.getString('loggedin_admin');
    if (laSerialized == null) return;
    final admin = AdminModel.fromSerialized(laSerialized);
    gpc.read(currentAdmin.notifier).state = admin;
    print('AutoLogged in as Admin(${admin.eid})');
  }

  static Future<List<DepartmentModel>> getAllDepartments() async {
    final res = await DioExecutor.get(
      url: '${HSCreds.baseURL}/getDepartment',
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, <DepartmentModel>[]);
    }
    final resdata = res.$1!;
    final deps = resdata['data'];
    return deps.map((x) => DepartmentModel.fromModel(x)).toList();
  }

  static createPatientAssessment() async {}

  static getAllActiveVisits() async {
    final res = await DioExecutor.get(
      url: '${HSCreds.baseURL}/getactivevisits?visittype=OUT&pageNo=0',
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, <PatientModel>[]);
    }
    final resdata = res.$1!;
    final pats = resdata['filteredresults'];
    return pats.map((x) => PatientModel.fromMap(x)).toList();
  }

  static Future<void> prescribeMedication({
    required DateTime start,
    required DateTime end,
    required String brandName,
    required String dosage,
    required MedicationFrequency freq,
  }) async {
    final res = await DioExecutor.post(
      url: '${HSCreds.baseURL}/addMedicationDetails',
      data: {
        "startedDate": start.millisecondsSinceEpoch,
        "endDate": end.millisecondsSinceEpoch,
        "prescriptionflg": 1,
        "brandName": brandName,
        "dosage": dosage,
        "frequency": "${freq.$1}-${freq.$2}-${freq.$3}",
        "visitEId": gpc.read(currentPatient)!.latestVisitId,
        "patientEId": gpc.read(currentPatient)!.patientEId,
      },
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, null);
    }
  }

  static addToPatientHistory() async {
    //TODO: We can use firebase here
  }
}
