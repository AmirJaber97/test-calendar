import 'package:intl/intl.dart';
import 'package:test_calendar/core/extensions.dart';
import 'package:test_calendar/models/day.dart';
import 'package:test_calendar/models/event.dart';

const _daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

class CalendarUtils {
  var dayOfWeek = 0;

  int numDaysInMonth(int year, int month) =>
      (month == DateTime.february && isLeapYear(year)) ? 29 : _daysInMonth[month];

  bool isLeapYear(int year) => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  List<Day> getDaysOfMonth(int month, int year, List<int> numberedDays, [List<Event>? events]) {
    List<Day> days = [];
    for (var element in numberedDays) {
      DateTime date = DateTime(year, month, element);
      Event? event;
      if (events != null) {
        event = events.firstWhereOrNull((Event event) => _isSameDate(event.eventDate, date));
      }
      Day day =
          Day(dayName: DateFormat('EEEE').format(date), dateTime: date, dayNumber: element, event: event?.eventDetails);
      days.add(day);
    }

    return days;
  }

  _isSameDate(DateTime? event, DateTime day) {
    return event?.year == day.year && event?.month == day.month && event?.day == day.day;
  }
}
