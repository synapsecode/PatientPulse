class DepartmentModel {
  final String eid;
  final String name;

  DepartmentModel({required this.eid, required this.name});

  factory DepartmentModel.fromModel(Map x) {
    return DepartmentModel(eid: x['deptEId'], name: x['deptName']);
  }
}
