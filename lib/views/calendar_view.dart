import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_calendar/constants/style/colors.dart';
import 'package:test_calendar/constants/style/style.dart';
import 'package:test_calendar/core/base_viewmodel.dart';
import 'package:test_calendar/viewmodels/calendar_viewmodel.dart';
import 'package:test_calendar/widgets/current_month_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget<CalendarViewModel>(
        viewModel: CalendarViewModel(),
        onViewModelReady: (calendarVM) => calendarVM.testCalendar(),
        builder: (ctx, calendarVM, _) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    height: ScreenUtil().screenHeight / 2.2,
                    child: Center(
                        child: Text(
                      calendarVM.selectedDay?.event ?? '',
                      style: robotoStyle(color: kWhiteColor),
                    )),
                  ),
                ),
                CurrentMonthCalendar(
                    lastMonthDays: calendarVM.endingDaysOfLastMonth,
                    nextMonthDays: calendarVM.startingDaysOfNextMonth,
                    days: calendarVM.days,
                    onDateSelected: (day) {
                      calendarVM.setDay(day);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
