import 'package:flutter/material.dart';
import 'package:livtu/constants/routes.dart';
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(editCalendarEventRoute),
      ),
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
              dataSource: MeetingDataSource(_getDataSource()),
            ),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
