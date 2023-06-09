import 'package:flutter/material.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/views/drawer.dart';
import 'package:livtu/services/schedule/provider/event_data_source.dart';
import 'package:livtu/services/schedule/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      drawer: getUniversalDrawer(context: context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(editCalendarEventRoute),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mySchedule),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.day;
                      _calendarKey = UniqueKey();
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.day),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.week;
                      _calendarKey = UniqueKey();
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.week),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.month;
                      _calendarKey = UniqueKey();
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.month),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.schedule;
                      _calendarKey = UniqueKey();
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.schedule),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCalendar(
              key: _calendarKey,
              view: _calendarView,
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments!.isEmpty) return;
                print(calendarTapDetails.appointments.toString());
                // final event = calendarTapDetails.appointments!.first;
                //Navigator.pushNamed(context, )
              },
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
                color: Colors.teal.shade200.withOpacity(0.1),
                shape: BoxShape.rectangle,
              ),
              showNavigationArrow: true,
              showWeekNumber: true,
              weekNumberStyle: WeekNumberStyle(
                backgroundColor: Colors.teal.shade100,
              ),
              monthViewSettings: const MonthViewSettings(showAgenda: true),
              dataSource: EventDataSource(events),
            ),
          ),
        ],
      ),
    );
  }
}
