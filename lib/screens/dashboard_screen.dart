import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/widgets/gauge.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveValue(
                    context,
                    defaultValue: 18.0,
                    conditionalValues: const [
                      Condition.smallerThan(
                        name: MOBILE,
                        value: 14.0,
                      ),
                      Condition.largerThan(
                        name: MOBILE,
                        value: 20.0,
                      ),
                      Condition.largerThan(
                        name: DESKTOP,
                        value: 28.0,
                      ),
                    ],
                  ).value,
                ),
              ),
            ),
            Flexible(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  int crossAxisCount =
                      ResponsiveBreakpoints.of(context).largerThan(TABLET)
                          ? 4
                          : 2;
                  double mainAxisExtent =
                      (constraints.maxWidth + 50) / crossAxisCount;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: mainAxisExtent,
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
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                factory.datetime,
                style: TextStyle(
                  fontSize: ResponsiveValue(
                    context,
                    defaultValue: 14.0,
                    conditionalValues: const [
                      Condition.smallerThan(
                        name: MOBILE,
                        value: 10.0,
                      ),
                      Condition.equals(
                        name: TABLET,
                        value: 16.0,
                      ),
                      Condition.equals(
                        name: DESKTOP,
                        value: 18.0,
                      ),
                      Condition.largerThan(
                        name: DESKTOP,
                        value: 28.0,
                      ),
                    ],
                  ).value,
                ),
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

  const InfoDetail({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.threshold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveValue(
                      context,
                      defaultValue: 14.0,
                      conditionalValues: const [
                        Condition.smallerThan(
                          name: MOBILE,
                          value: 10.0,
                        ),
                        Condition.equals(
                          name: TABLET,
                          value: 18.0,
                        ),
                        Condition.largerThan(
                          name: DESKTOP,
                          value: 28.0,
                        ),
                      ],
                    ).value,
                  ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ResponsiveValue(
                        context,
                        defaultValue: 18.0,
                        conditionalValues: const [
                          Condition.smallerThan(
                            name: MOBILE,
                            value: 14.0,
                          ),
                          Condition.equals(
                            name: TABLET,
                            value: 22.0,
                          ),
                          Condition.largerThan(
                            name: DESKTOP,
                            value: 32.0,
                          ),
                        ],
                      ).value,
                    ),
                  ),
                  Text(
                    unit,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ResponsiveValue(
                        context,
                        defaultValue: 12.0,
                        conditionalValues: const [
                          Condition.smallerThan(
                            name: MOBILE,
                            value: 8.0,
                          ),
                          Condition.equals(
                            name: TABLET,
                            value: 16.0,
                          ),
                          Condition.largerThan(
                            name: DESKTOP,
                            value: 26.0,
                          ),
                        ],
                      ).value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
