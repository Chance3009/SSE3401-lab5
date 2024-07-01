import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsDetail extends StatefulWidget {
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
  State<SettingsDetail> createState() => _SettingsDetailState();
}

class _SettingsDetailState extends State<SettingsDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
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
                  child: widget.isEditing
                      ? TextField(
                          keyboardType: TextInputType.number,
                          controller: widget.controller,
                          onChanged: (newValue) =>
                              widget.onValueChanged(double.parse(newValue)),
                          textAlign: TextAlign.center,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.value.toString(),
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
                    widget.unit,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
