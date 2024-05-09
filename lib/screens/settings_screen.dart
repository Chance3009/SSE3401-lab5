import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';

class SettingsPage extends StatefulWidget {
  final int factoryIndex;

  const SettingsPage({super.key, required this.factoryIndex});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SettingsPanel(factory: factories[widget.factoryIndex]),
    );
  }
}

class SettingsPanel extends StatefulWidget {
  final Factory factory;

  const SettingsPanel({super.key, required this.factory});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  bool isEditing = false;
  final TextEditingController _steamPressureController =
      TextEditingController();
  final TextEditingController _steamFlowController = TextEditingController();
  final TextEditingController _waterLevelController = TextEditingController();
  final TextEditingController _powerFrequencyController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _steamPressureController.text =
        widget.factory.threshold.steamPressure.toString();
    _steamFlowController.text = widget.factory.threshold.steamFlow.toString();
    _waterLevelController.text = widget.factory.threshold.waterLevel.toString();
    _powerFrequencyController.text =
        widget.factory.threshold.powerFrequency.toString();
  }

  void _updateFactoryThresholdValues() {
    setState(() {
      widget.factory.threshold.steamPressure =
          double.parse(_steamPressureController.text);
      widget.factory.threshold.steamFlow =
          double.parse(_steamFlowController.text);
      widget.factory.threshold.waterLevel =
          double.parse(_waterLevelController.text);
      widget.factory.threshold.powerFrequency =
          double.parse(_powerFrequencyController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<double> values = [
      widget.factory.threshold.steamPressure,
      widget.factory.threshold.steamFlow,
      widget.factory.threshold.waterLevel,
      widget.factory.threshold.powerFrequency
    ];

    final List<TextEditingController> controllers = [
      _steamPressureController,
      _steamFlowController,
      _waterLevelController,
      _powerFrequencyController
    ];

    return Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Minimum Threshold",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.info_outline),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (isEditing) {
                            _updateFactoryThresholdValues();
                          }
                          isEditing = !isEditing;
                        });
                      },
                      label: const Text(""),
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return SettingsDetail(
                      title: details[index],
                      value: values[index],
                      unit: units[index],
                      isEditing: isEditing,
                      onValueChanged: (newValue) {
                        setState(() {
                          values[index] = newValue;
                        });
                      },
                      controller: controllers[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class SettingsDetail extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final bool isEditing;
  final Function(double) onValueChanged;
  final TextEditingController controller;

  const SettingsDetail({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.isEditing,
    required this.onValueChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: isEditing
                      ? TextField(
                          keyboardType: TextInputType.number,
                          controller: controller,
                          onChanged: (newValue) =>
                              onValueChanged(double.parse(newValue)),
                          textAlign: TextAlign.center,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    unit,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
