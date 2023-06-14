import 'package:flutter/material.dart';

class Train{
  final String id;
  final String name;
  final String from_location;
  final String to_location;
  final TimeOfDay departure_time;
  final TimeOfDay arrival_time;
  final DateTime date;
  final String duration;
  final String distance;

  const Train(
      this.id,
      this.name,
      this.from_location,
      this.to_location,
      this.departure_time,
      this.arrival_time,
      this.date,
      this.duration,
      this.distance);
}