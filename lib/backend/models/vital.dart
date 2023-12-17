class VitalModel {
  final String? eid;
  final String name;
  final String unit;
  String? value;
  final DateTime? checkedDate;
  final String code;
  final String measurementId;

  VitalModel({
    required this.eid,
    required this.unit,
    required this.name,
    required this.value,
    required this.checkedDate,
    required this.code,
    required this.measurementId,
  });

  bool get isValid => eid != null;
  bool get hasValue => value != null;

  factory VitalModel.fromMap(Map x) {
    return VitalModel(
      code: x['code'],
      measurementId: x['measurementId'].toString(),
      eid: x['eid'],
      name: x['name'],
      unit: x['measurementUnit'],
      value: x['value'] ?? '-',
      checkedDate: x['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(x['createdDate'])
          : null,
    );
  }
}
