import 'package:flutter/foundation.dart';
import 'package:livtu/views/schedule/event_model.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}