class ProgressHistory {
  final String title;
  final String message;
  final String doctorName;
  final DateTime? date;

  ProgressHistory({
    required this.title,
    required this.message,
    required this.doctorName,
    required this.date,
  });
  factory ProgressHistory.fromMap(Map x) {
    return ProgressHistory(
      title: x['title'] ?? 'Untitled',
      message: x['message'] ?? 'unspecified message',
      doctorName: x['doctorName'] ?? 'Unknown Doctor',
      date: x['createdTs'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              x['createdTs'],
            )
          : null,
    );
  }
}
