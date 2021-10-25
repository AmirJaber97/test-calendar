import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_calendar/views/calendar_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp( const TestCalendar());
  });
}

class TestCalendar extends StatelessWidget {
  const TestCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const CalendarView(),
      ),
    );
  }
}
