import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatelessWidget {
  final double value;
  final double threshold;

  const Gauge({
    super.key,
    required this.value,
    required this.threshold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 1500,
          axes: <RadialAxis>[
            RadialAxis(
              showLabels: false,
              startAngle: 180,
              endAngle: 0,
              canScaleToFit: true,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: value,
                    color: value < threshold ? Colors.red : Colors.green,
                    startWidth: 10,
                    endWidth: 10),
              ],
              pointers: <GaugePointer>[
                MarkerPointer(value: threshold, markerOffset: -10)
              ],
            )
          ]),
    );
  }
}
