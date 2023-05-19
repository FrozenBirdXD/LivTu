import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color color;
  final bool isAllDay;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.color,
    this.isAllDay = false,
  });

  @override
  String toString() {
    return 'Title: $title, Description: $description, From: $from, To: $to, Color: $color, IsAllDay: $isAllDay';
  }
}
