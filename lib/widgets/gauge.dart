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
    const double thicknessFactor = 0.2;

    final double widgetSize =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;
    final double gaugeThickness = widgetSize * thicknessFactor;
    final double markerOffset = -gaugeThickness * 0.25;

    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 1500,
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          startAngle: 180,
          endAngle: 0,
          canScaleToFit: true,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.2,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: value,
              color: value < threshold ? Colors.red : Colors.green,
              width: 0.2,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            MarkerPointer(
              value: threshold,
              markerOffset: markerOffset,
            ),
          ],
        ),
      ],
    );
  }
}
