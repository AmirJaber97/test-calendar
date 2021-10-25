class Day {
  String dayName;
  int dayNumber;
  DateTime dateTime;
  String? event;

  Day({required this.dayName, required this.dayNumber, required this.dateTime, this.event});

  @override
  String toString() {
    return '$dayName the $dayNumber, timestamp ${dateTime.millisecondsSinceEpoch}';
  }
}