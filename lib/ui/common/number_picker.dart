import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

class NumberPicker extends StatelessWidget {
  const NumberPicker({
    super.key,
    required this.current,
    required this.onChange,
    this.max,
    this.increment = 1,
    this.min,
  });

  final double current;
  final double increment;
  final double? max;
  final double? min;
  final void Function(double value) onChange;

  void incrementNum() {
    if (max != null && current >= max!) return;

    onChange(current + increment);
  }

  void decrementNum() {
    if (min != null && current <= min!) return;

    onChange(current - increment);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HoldDetector(
          onHold: decrementNum,
          enableHapticFeedback: true,
          holdTimeout: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: decrementNum,
            icon: const Icon(Icons.remove),
          ),
        ),
        Text((current % 1 == 0 ? current.toInt() : current).toString()),
        HoldDetector(
          onHold: incrementNum,
          enableHapticFeedback: true,
          holdTimeout: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: incrementNum,
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
