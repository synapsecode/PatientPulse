class VitalModel {
  final String? eid;
  final String name;
  final String unit;
  final String? value;
  final DateTime? checkedDate;

  VitalModel({
    required this.eid,
    required this.unit,
    required this.name,
    required this.value,
    required this.checkedDate,
  });

  bool get isValid => eid != null;
  bool get hasValue => value != null;

  factory VitalModel.fromModel(Map x) {
    return VitalModel(
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
