class AdminModel {
  final String eid;
  final String accessToken;

  AdminModel({
    required this.eid,
    required this.accessToken,
  });
  factory AdminModel.fromMap(Map x) {
    return AdminModel(
      eid: x['userEId'],
      accessToken: x['access_token'],
    );
  }

  String serialize() {
    return [eid, accessToken].join('::');
  }

  factory AdminModel.fromSerialized(String x) {
    final parts = x.split('::');
    return AdminModel(
      eid: parts[0],
      accessToken: parts[1],
    );
  }
}
