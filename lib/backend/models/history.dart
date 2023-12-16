class ProgressHistory {
  final String title;
  final String message;
  final String doctorName;
  final DateTime date;

  ProgressHistory({
    required this.title,
    required this.message,
    required this.doctorName,
    required this.date,
  });
  factory ProgressHistory.fromMap(Map x) {
    return ProgressHistory(
      title: x['progressHistory']['title'],
      message: x['progressHistory']['message'],
      doctorName: x['progressHistory']['doctorName'],
      date: DateTime.fromMillisecondsSinceEpoch(
        x['progressHistory']['createdTs'],
      ),
    );
  }
}
