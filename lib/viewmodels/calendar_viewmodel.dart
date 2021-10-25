import 'package:test_calendar/core/base_provider.dart';
import 'package:test_calendar/core/extensions.dart';
import 'package:test_calendar/models/day.dart';
import 'package:test_calendar/models/event.dart';
import 'package:test_calendar/utils/calendar_utils.dart';

List<Event> _events = [
  Event("here's event 1", DateTime.now()),
  Event("another event", DateTime.now().subtract(const Duration(days: 3))),
  Event("stuff going on", DateTime.now().subtract(const Duration(days: 2))),
  Event("another thing", DateTime.now().add(const Duration(days: 3))),
  Event("some stuff", DateTime.now().add(const Duration(days: 10))),
];

class CalendarViewModel extends BaseProvider {
  final CalendarUtils _calendarUtils = CalendarUtils();
  final DateTime _today = DateTime.now();
  late int year, month, day;
  late int numberOfDays;

  int thisWeekNum = 1;
  int weekNum = 1;
  List<int> daysOfMonth = [];
  List<Day> days = [];
  List<Day> endingDaysOfLastMonth = [];
  List<Day> startingDaysOfNextMonth = [];
  List<List<Day>> weeks = [];
  List<Day> week = [];
  Day? _selectedDay;

  Day? get selectedDay => _selectedDay;

  void setDay(Day day) {
    _selectedDay = day;
    notifyListeners();
  }

  void testCalendar() {
    getCalendar(_today.month, _today.year, _today.day, _events);
  }

  void getCalendar(int month, int year, int day, List<Event> events) {
    numberOfDays = _calendarUtils.numDaysInMonth(year, month);
    daysOfMonth = List<int>.generate(numberOfDays, (i) => i + 1);
    days = _calendarUtils.getDaysOfMonth(month, year, daysOfMonth, events);
    if (days.first.dateTime.weekday != 1) {
      previousMonthDays(month, year, events);
    }

    bool startWithLastMonthDays = endingDaysOfLastMonth.isNotEmpty;
    for (var i = 0; i < numberOfDays; i += 7) {
      var end = (i + 7 < numberOfDays) ? i + 7 : numberOfDays;
      weeks.add(days.sublist(i, startWithLastMonthDays ? end - endingDaysOfLastMonth.length : end));
      if (startWithLastMonthDays) i -= endingDaysOfLastMonth.length;
      startWithLastMonthDays = false;
    }

    weeks.forEachIndex((currentWeek, index) {
      for (var dayObj in currentWeek) {
        if (dayObj.dayNumber == day) {
          week = currentWeek;
          thisWeekNum = index + 1;
          weekNum = index + 1;
        }
      }
    });
    if ((weekNum == weeks.length) && (week.length < 7)) {
      nextMonthDays(month, year, events);
    }
  }

  void previousMonthDays(int month, int year, List<Event> events) {
    int numberOfLastMonthDays;
    List<int> daysOfLastMonth;
    int lastMonth;
    int lastYear;
    List<Day> lastMonthDays = [];
    if (month-- == 1) {
      lastMonth = 12;
      lastYear = year--;
    } else {
      lastMonth = month--;
      lastYear = year;
    }
    numberOfLastMonthDays = _calendarUtils.numDaysInMonth(lastYear, lastMonth);
    daysOfLastMonth = List<int>.generate(numberOfLastMonthDays, (i) => i + 1);
    lastMonthDays = _calendarUtils.getDaysOfMonth(lastMonth, lastYear, daysOfLastMonth, events);
    endingDaysOfLastMonth.addAll(lastMonthDays.sublist(numberOfLastMonthDays - days.first.dateTime.weekday + 1));
  }

  void nextMonthDays(int month, int year, List<Event> events) {
    var numberOfNextMonthDays;
    var daysOfNextMonth;
    var nextMonth;
    var nextYear;
    List<Day> nextMonthDays = [];
    if (month == 12) {
      nextYear = year + 1;
      nextMonth = 1;
    } else {
      nextMonth = month + 1;
      nextYear = year;
    }
    numberOfNextMonthDays = _calendarUtils.numDaysInMonth(nextYear, nextMonth);
    daysOfNextMonth = List<int>.generate(numberOfNextMonthDays, (i) => i + 1);
    nextMonthDays = _calendarUtils.getDaysOfMonth(nextMonth, nextYear, daysOfNextMonth, events);
    startingDaysOfNextMonth.addAll(nextMonthDays.sublist(0, 7 - week.length));
  }

  bool isLastMonth() {
    return month == _today.month && year == _today.year;
  }

  bool isLastWeek() {
    bool isLastWeek = false;
    if (isLastMonth()) {
      for (var day in week) {
        if (day.dayNumber == this._today.day) {
          isLastWeek = true;
        }
      }
    }
    return isLastWeek;
  }
}
