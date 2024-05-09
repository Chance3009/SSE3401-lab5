import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/widgets/gauge.dart';

class Dashboard extends StatefulWidget {
  final int factoryIndex;

  const Dashboard({super.key, required this.factoryIndex});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          InfoPanel(factory: factories[widget.factoryIndex], key: UniqueKey()),
    );
  }
}

class InfoPanel extends StatelessWidget {
  final Factory factory;

  const InfoPanel({super.key, required this.factory});

  @override
  Widget build(BuildContext context) {
    final List<double> values = [
      factory.steamPressure,
      factory.steamFlow,
      factory.waterLevel,
      factory.powerFrequency
    ];

    final List<double> thresholds = [
      factory.threshold.steamPressure,
      factory.threshold.steamFlow,
      factory.threshold.waterLevel,
      factory.threshold.powerFrequency
    ];

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                factory.status,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return InfoDetail(
                    title: details[index],
                    value: values[index],
                    unit: units[index],
                    threshold: thresholds[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                factory.datetime,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoDetail extends StatelessWidget {
  final String title;
  final double value;
  final double threshold;
  final String unit;

  const InfoDetail(
      {super.key,
      required this.title,
      required this.value,
      required this.unit,
      required this.threshold});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(240, 255, 255, 255),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            child: Gauge(
              value: value,
              threshold: threshold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              Text(unit,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
