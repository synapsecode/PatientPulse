import 'package:patientpulse/backend/admin.dart';
import 'package:patientpulse/backend/dioexecutor.dart';
import 'package:patientpulse/backend/healthscore.dart';
import 'package:patientpulse/backend/models/medication.dart';
import 'package:patientpulse/backend/models/patient.dart';
import 'package:patientpulse/backend/models/vital.dart';
import 'package:patientpulse/backend/utils.dart';
import 'package:patientpulse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HSPatient {
  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final cred = username.hashCode ^ password.hashCode;
    final patient = hsPatientDataMapping[cred];
    if (patient == null) {
      return false;
    }
    print('Logged in as Patient(${patient!.patientName})');
    gpc.read(currentPatient.notifier).state = patient;
    print('SavingPatientExtract => ${patient.serialize()}');
    await prefs.setString('loggedin_patient', patient.serialize());
    print('Performing AccessTokenFetchOnly');
    await HSAdmin.login('8660033751', '0000', accessTokenFetchOnly: true);
    return true;
  }

  static logout() async {
    final prefs = await SharedPreferences.getInstance();
    gpc.read(currentPatient.notifier).state = null;
    await prefs.remove('loggedin_patient');
    print('Logged Out from Patient');
  }

  static tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final lpSerialized = prefs.getString('loggedin_patient');
    if (lpSerialized == null) return;
    final patient = PatientModel.fromSerialized(lpSerialized);
    final adminAccessToken = prefs.getString('admin_accesstoken');
    gpc.read(bearerTokenProvider.notifier).state = adminAccessToken;
    gpc.read(currentPatient.notifier).state = patient;
    print('AutoLogged in as Patient(${patient!.patientName})');
  }

  static Future<List> getMyVitals() async {
    final peid = gpc.read(currentPatient)!.patientEId;
    final res = await DioExecutor.get(
      url: '${HSCreds.baseURL}/patientVitals?patientEId=$peid',
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, <VitalModel>[]);
    }
    final resdata = res.$1!;
    final vitals = resdata['data'];
    return vitals.map((x) => VitalModel.fromModel(x)).toList();
  }

  getHistory() async {}

  getPatientAssessmentResult() {}

  static Future<List> getMyMedications() async {
    final peid = gpc.read(currentPatient)!.patientEId;
    final res = await DioExecutor.get(
      url: '${HSCreds.baseURL}/getCurrentMedicationDetails?patientEId=$peid',
    );
    if (res.$2 != null) {
      return commonErrorHandler(res.$2!, <MedicationModel>[]);
    }
    final resdata = res.$1!;
    final meds = resdata['data'];
    return meds.map((x) => MedicationModel.fromMap(x)).toList();
  }
}

Map<int, PatientModel> hsPatientDataMapping = {
  ('manashejmadi'.hashCode ^ '12345'.hashCode): patientData[0],
  ('alicebanks'.hashCode ^ '12345'.hashCode): patientData[1],
  ('tomsepolia'.hashCode ^ '12345'.hashCode): patientData[2],
  ('shlokmange'.hashCode ^ '12345'.hashCode): patientData[3],
  ('irrfansolana'.hashCode ^ '12345'.hashCode): patientData[4],
};

final List<PatientModel> patientData = [
  PatientModel(
    patientEId: 'ONeqqJDqZ4JYnEReeC-fpQ==',
    patientName: 'John Doe',
    latestVisitId: 'UfKJFAorhF2Y9yB-S2oPJQ==',
  ),
  PatientModel(
    patientEId: 'dSPvAjVoGBN-uw-PMz-V5g==',
    patientName: 'Alice Banks',
    latestVisitId: 'L208Tkr4l0BBXCh_1foWSA==',
  ),
  PatientModel(
    patientEId: 'OkX7GvOpP5zIJ56f1UR_sg==',
    patientName: 'Tom Sepolia',
    latestVisitId: '7EPviKhfaD_JtxhB12E3gw==',
  ),
  PatientModel(
    patientEId: 'PM7o52BLebjiErkZHlQbsA==',
    patientName: 'Shlok Mange',
    latestVisitId: 'GNxavtia1pG4gnphnyJVug==',
  ),
  PatientModel(
    patientEId: '5vWuQboJe8vhphy8prP97g==',
    patientName: 'Irrfan Solana',
    latestVisitId: 'XPeoD-KOj9MhmdooIE3kCA==',
  ),
];
