import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';

class Schedule {
  String name = "";
  String budgetType = "";
  int budget = 0;
  int travelerNum = 0;
  List<DateTime> dates = [DateTime.now(), DateTime.now()];
  List<TimeOfDay> time = [TimeOfDay.now(), TimeOfDay.now()];
  List<List<Place>> places = [];
  List<List<String>> activities = [];
  DateTime createdDate = DateTime.now();
  String response = "";

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

Schedule exampleSchedule = Schedule(
  "Manjanggul Journey",
  "budget friendly",
  100,
  2,
  [DateTime.now(), DateTime.now().add(Duration(days: 1))],
  [TimeOfDay.now(), TimeOfDay.now()],
  [
    [places[0], places[1], places[2]],
    [places[3], places[4], places[5]],
  ],
);

String exampleResponse = """
[
      [
        {
          "morning": {
            "places": "${exampleSchedule.places[0][0].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          },
          "afternoon": {
            "places": "${exampleSchedule.places[0][1].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          },
          "evening": {
            "places": "${exampleSchedule.places[0][2].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          }
        }
      ],
      [
        {
          "morning": {
            "places": "${exampleSchedule.places[1][0].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          },
          "afternoon": {
            "places": "${exampleSchedule.places[1][1].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          },
          "evening": {
            "places": "${exampleSchedule.places[1][2].name}",
            "activities": "an attractive description about activities to do here",
            "cost": cost(int)
          }
        }
      ],
      [
        {
          "total_cost": total_cost for all days,
          "accommodation_cost": cost for accommodation,
          "transport_cost": transport_cost,
          "food_cost": food_cost
        }
      ]
    ]
    """;
