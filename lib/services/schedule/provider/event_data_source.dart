import 'package:flutter/material.dart';
import 'package:livtu/views/schedule/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) {
    return appointments![index] as Event;
  }

  @override
  DateTime getStartTime(int index) => getEvent(index).from;
  
  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;


  @override
  Color getColor (int index) => getEvent(index).color;

  @override
  bool isAllDay (int index) => getEvent(index).isAllDay;
}
