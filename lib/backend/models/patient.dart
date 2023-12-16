class PatientModel {
  final String patientEId;
  final String patientName;
  final String latestVisitId;

  PatientModel({
    required this.patientEId,
    required this.patientName,
    required this.latestVisitId,
  });
  factory PatientModel.fromMap(Map x) {
    return PatientModel(
      patientEId: x['patientEId'],
      patientName: x['patientName'],
      latestVisitId: 'visitEId',
    );
  }
}
