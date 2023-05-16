import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  Key _calendarKey = UniqueKey();
  CalendarView _calendarView = CalendarView.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calendarView = CalendarView.day;
                    _calendarKey = UniqueKey();
                  });
                },
                child: const Text('Day'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calendarView = CalendarView.week;
                    _calendarKey = UniqueKey();
                  });
                },
                child: const Text('Week'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calendarView = CalendarView.month;
                    _calendarKey = UniqueKey();
                  });
                },
                child: const Text('Month'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calendarView = CalendarView.schedule;
                    _calendarKey = UniqueKey();
                  });
                },
                child: const Text('Schedule'),
              ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              key: _calendarKey,
              view: _calendarView,
              firstDayOfWeek: 1,
              onViewChanged: (ViewChangedDetails details) {},
              selectionDecoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                shape: BoxShape.rectangle,
              ),
              showNavigationArrow: true,
              showWeekNumber: true,
              weekNumberStyle: WeekNumberStyle(
                backgroundColor: Colors.teal.shade100,
              ),
              monthViewSettings: const MonthViewSettings(showAgenda: true),
            ),
          ),
        ],
      ),
    );
  }
}
