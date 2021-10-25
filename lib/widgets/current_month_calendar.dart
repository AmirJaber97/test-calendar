import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_calendar/constants/style/colors.dart';
import 'package:test_calendar/constants/style/font_sizes.dart';
import 'package:test_calendar/constants/style/font_weights.dart';
import 'package:test_calendar/constants/style/style.dart';
import 'package:test_calendar/models/day.dart';
import 'package:test_calendar/viewmodels/calendar_viewmodel.dart';

const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

class CurrentMonthCalendar extends StatelessWidget {
  const CurrentMonthCalendar(
      {Key? key, required this.lastMonthDays, required this.nextMonthDays, required this.days, this.onDateSelected})
      : super(key: key);

  final List<Day> lastMonthDays;
  final List<Day> nextMonthDays;
  final List<Day> days;
  final Function(Day day)? onDateSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            DateFormat('MMMM yyyy').format(DateTime.now()),
            style: robotoStyle(fSize: FontSize().header, fWeight: kBold),
          ),
        ),
        Container(
            height: 35,
            decoration:
                const BoxDecoration(color: kLightPurpleColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: weekDays
                  .map((e) => Expanded(
                          child: Center(
                              child: Text(
                        e,
                        style: robotoStyle(fWeight: kBold),
                      ))))
                  .toList(),
            )),
        GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 7,
          children: [
            if (lastMonthDays.isNotEmpty) ...lastMonthDays.map((e) => _dateWidget(e)).toList(),
            if (days.isNotEmpty) ...days.map((e) => _dateWidget(e)).toList(),
            if (nextMonthDays.isNotEmpty) ...nextMonthDays.map((e) => _dateWidget(e)).toList()
          ],
        ),
      ],
    );
  }

  Widget _dateWidget(Day day) {
    return Consumer<CalendarViewModel>(builder: (ctx, calendarVM, _) {
      bool selectedDay = calendarVM.selectedDay == day;
      return GestureDetector(
        onTap: () => onDateSelected!(day),
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: selectedDay ? kPrimaryColor : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(7))),
                child: Center(
                    child: Text(
                  '${day.dateTime.day}',
                  style: robotoStyle(color: selectedDay ? kWhiteColor : kBlackColor),
                ))),
            day.event != null
                ? Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                          shape: BoxShape.circle),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      );
    });
  }
}
