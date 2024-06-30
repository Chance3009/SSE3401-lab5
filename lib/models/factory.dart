import 'package:flutter/material.dart';

class Factory {
  final String factoryName;
  String status;
  double steamPressure;
  double steamFlow;
  double waterLevel;
  double powerFrequency;
  String datetime;
  Color color;

  final List<Engineer> engineers;
  final Threshold threshold;

  Factory({
    required this.factoryName,
    required this.status,
    required this.steamPressure,
    required this.steamFlow,
    required this.waterLevel,
    required this.powerFrequency,
    required this.datetime,
    required this.engineers,
    required this.threshold,
    required this.color,
  });
}

class Engineer {
  final String name;
  final String phone;

  Engineer({
    required this.name,
    required this.phone,
  });
}

class Threshold {
  double steamPressure;
  double steamFlow;
  double waterLevel;
  double powerFrequency;

  Threshold({
    required this.steamPressure,
    required this.steamFlow,
    required this.waterLevel,
    required this.powerFrequency,
  });
}

List<Factory> factories = [
  Factory(
    factoryName: "Factory 1",
    status: "⚠️ ABD1234 IS UNREACHABLE!",
    steamPressure: 0.0,
    steamFlow: 0.0,
    waterLevel: 0.0,
    powerFrequency: 0.0,
    datetime: "--:--",
    engineers: [
      Engineer(name: "Ben", phone: "+60109219938"),
      Engineer(name: "Testing 1", phone: "+601234567891"),
      Engineer(name: "Hello", phone: "+60123456789")
    ],
    threshold: Threshold(
      steamPressure: 30,
      steamFlow: 25,
      waterLevel: 52,
      powerFrequency: 48,
    ),
    color: Colors.amber,
  ),
  Factory(
    factoryName: "Factory 2",
    status: "1549.7kW",
    steamPressure: 34.19,
    steamFlow: 22.8,
    waterLevel: 55.41,
    powerFrequency: 50.08,
    datetime: "2024-04-26 13:45:25",
    engineers: [
      Engineer(name: "Nancy", phone: "+60127859684"),
      Engineer(name: "Lee", phone: "+60178543875"),
    ],
    threshold: Threshold(
      steamPressure: 30,
      steamFlow: 25,
      waterLevel: 52,
      powerFrequency: 48,
    ),
    color: Colors.white,
  ),
  Factory(
    factoryName: "Factory 3",
    status: "2013.4kW",
    steamPressure: 56.78,
    steamFlow: 35.15,
    waterLevel: 60.11,
    powerFrequency: 58.81,
    datetime: "2024-04-26 13:46:37",
    engineers: [
      Engineer(name: "Ahmad", phone: "+60134487766"),
      Engineer(name: "Neo", phone: "+60102756478"),
      Engineer(name: "Nana", phone: "+60153445645"),
      Engineer(name: "Ling", phone: "+6015786578"),
    ],
    threshold: Threshold(
      steamPressure: 29,
      steamFlow: 22,
      waterLevel: 53,
      powerFrequency: 48,
    ),
    color: Colors.white,
  ),
  Factory(
    factoryName: "Factory 4",
    status: "⚠️ XYZ6666 IS UNREACHABLE!",
    steamPressure: 0.0,
    steamFlow: 0.0,
    waterLevel: 0.0,
    powerFrequency: 0.0,
    datetime: "--:--",
    engineers: [
      Engineer(name: "Noname", phone: "+6014123458"),
    ],
    threshold: Threshold(
      steamPressure: 20,
      steamFlow: 20,
      waterLevel: 20,
      powerFrequency: 20,
    ),
    color: Colors.white,
  ),
];

final List<String> details = [
  "Steam Pressure",
  "Steam Flow",
  "Water Level",
  "Power Frequency"
];

final List<String> units = ["bar", "T/H", "%", "Hz"];
