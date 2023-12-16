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
      latestVisitId: x['visitEId'],
    );
  }

  String serialize() {
    return [patientEId, patientName, latestVisitId].join('::');
  }

  factory PatientModel.fromSerialized(String x) {
    final parts = x.split('::');
    return PatientModel(
      patientEId: parts[0],
      patientName: parts[1],
      latestVisitId: parts[2],
    );
  }
}
