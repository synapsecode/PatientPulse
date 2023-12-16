class MedicationModel {
  final String eid;
  final String dosage;
  final String brandName;
  final MedicationDuration courseDuration;
  final MedicationFrequency frequency;
  final String doctorUserEId;

  MedicationModel({
    required this.eid,
    required this.dosage,
    required this.brandName,
    required this.courseDuration,
    required this.frequency,
    required this.doctorUserEId,
  });

  factory MedicationModel.fromMap(Map x) {
    final freq = x['frequency'].split('-');
    return MedicationModel(
      eid: x['medicationDetailsEId'],
      dosage: x['dosage'] ?? 'standard',
      brandName: x['brandName'],
      courseDuration: (
        start: DateTime.fromMicrosecondsSinceEpoch(x['startedDate']),
        end: DateTime.fromMillisecondsSinceEpoch(x['endDate'])
      ),
      frequency: (freq[0], freq[1], freq[2]),
      doctorUserEId: x['doctoruserEId'],
    );
  }

  bool get isActive {
    return DateTime.now().millisecondsSinceEpoch <
        courseDuration.end.millisecondsSinceEpoch;
  }
}

typedef MedicationFrequency = (String m, String a, String n);
typedef MedicationDuration = ({DateTime start, DateTime end});
