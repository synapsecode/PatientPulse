import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patientpulse/backend/dioexecutor.dart';
import 'package:patientpulse/backend/healthscore.dart';
import 'package:patientpulse/backend/models/admin.dart';
import 'package:patientpulse/backend/models/department.dart';
import 'package:patientpulse/backend/models/medication.dart';
import 'package:patientpulse/backend/models/patient.dart';
import 'package:patientpulse/backend/models/vital.dart';
import 'package:patientpulse/backend/patients.dart';
import 'package:patientpulse/backend/utils.dart';
import 'package:patientpulse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currentPatient = StateProvider<PatientModel?>((ref) => null);
final activePatient = StateProvider<PatientModel?>((ref) => null);
final bearerTokenProvider = StateProvider<String?>((ref) => null);
final currentAdmin = StateProvider<AdminModel?>((ref) => null);

class HSAdmin {
  static Future<bool> login(
    String username,
    String password, {
    bool accessTokenFetchOnly = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await DioExecutor.get(
      url: HSCreds.getLoginURL(username: username, password: password),
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, false);
    }
    final admin = AdminModel.fromMap(res.$1!);
    if (!accessTokenFetchOnly) {
      gpc.read(currentAdmin.notifier).state = admin;
      print('SavingPatientExtract => ${admin.serialize()}');
      await prefs.setString('loggedin_admin', admin.serialize());
    } else {
      gpc.read(bearerTokenProvider.notifier).state = admin.accessToken;
      await prefs.setString('admin_accesstoken', admin.accessToken);
    }
    return true;
  }

  static logout() async {
    final prefs = await SharedPreferences.getInstance();
    gpc.read(currentAdmin.notifier).state = null;
    gpc.read(bearerTokenProvider.notifier).state = null;

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

  static Future<List> getAllDepartments() async {
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

  static Future<bool> checkinPatient(String fullName) async {
    final x = patientData
        .where((e) => e.patientName.toLowerCase() == fullName.toLowerCase());
    if (x.isEmpty) return false;
    gpc.read(activePatient.notifier).state = x.first;
    return true;
  }

  static void checkoutPatient() {
    gpc.read(activePatient.notifier).state = null;
  }

  static createPatientAssessment() async {}

  static Future<List> getAllActiveVisits() async {
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
        "visitEId": gpc.read(activePatient)!.latestVisitId,
        "patientEId": gpc.read(activePatient)!.patientEId,
      },
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, null);
    }
  }

  static Future<void> updateVitals({
    required List vitals,
    required PatientModel patient,
  }) async {
    final res = await DioExecutor.post(
      url: '${HSCreds.baseURL}/updatePatientVitals',
      data: {
        "updatedVitals": [
          ...vitals
              .map((x) => {
                    "eid": patient.patientEId,
                    "visitEId": patient.latestVisitId,
                    "code": x.code,
                    "value": x.value,
                    "measurementId": x.measurementId,
                  })
              .toList(),
        ]
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
