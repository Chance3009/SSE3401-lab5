import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? icon;
  final Widget? label;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double size = ResponsiveValue(
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
        Condition.equals(
          name: DESKTOP,
          value: 22.0,
        ),
        Condition.largerThan(
          name: DESKTOP,
          value: 30.0,
        ),
      ],
    ).value;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ?? const SizedBox.shrink(),
      label: label ?? const SizedBox.shrink(),
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.all(size),
        textStyle: TextStyle(fontSize: size),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
    );
  }
}
