import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';

class Schedule {
  String name = "";
  String budgetType = "";
  List<int> budget = [0, 0];
  int travelerNum = 0;
  List<DateTime> dates = [DateTime.now(), DateTime.now()];
  List<TimeOfDay> time = [TimeOfDay.now(), TimeOfDay.now()];
  List<List<Place>> places = [];
  List<List<String>> activities = [];
  DateTime createdDate = DateTime.now();

  Schedule(
    this.name,
    this.budgetType,
    this.budget,
    this.travelerNum,
    this.dates,
    this.time,
    this.places,
  );

  Schedule.full(
    this.name,
    this.budgetType,
    this.budget,
    this.travelerNum,
    this.dates,
    this.time,
    this.places,
    this.activities,
  );
}
