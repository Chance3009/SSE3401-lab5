import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/widgets/custom_button.dart';
import 'package:lab5/widgets/setting_detail.dart';

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
      widget.factory.threshold.powerFrequency,
    ];

    final List<TextEditingController> controllers = [
      _steamPressureController,
      _steamFlowController,
      _waterLevelController,
      _powerFrequencyController,
    ];

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Minimum Threshold",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.info_outline),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  int crossAxisCount = constraints.maxWidth > 1024 ? 4 : 2;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1,
                      mainAxisExtent: 150,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        child: SettingsDetail(
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomButton(
                onPressed: () {
                  setState(() {
                    _updateFactoryThresholdValues();
                    isEditing = false;
                  });
                },
                label: const Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
