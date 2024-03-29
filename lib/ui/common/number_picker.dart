import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

class NumberPicker extends StatelessWidget {
  const NumberPicker({
    super.key,
    this.number,
    this.hint,
    required this.onIncrement,
    required this.onDecrement,
  });

  final num? number;
  final String? hint;
  final void Function() onIncrement;
  final void Function() onDecrement;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    late String? value;

    if (number != null && number != 0) {
      if (number == (number ?? 0).roundToDouble()) {
        value = number!.truncate().toString();
      } else {
        value = number!.toString();
      }
    } else {
      value = null;
    }

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.hintColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value ?? hint ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: value == null ? theme.hintColor : null),
              ),
            ),
            Row(
              children: [
                HoldDetector(
                  onHold: onIncrement,
                  enableHapticFeedback: true,
                  holdTimeout: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up),
                    color: Colors.grey[400],
                    onPressed: onIncrement,
                  ),
                ),
                HoldDetector(
                  onHold: onDecrement,
                  enableHapticFeedback: true,
                  holdTimeout: const Duration(milliseconds: 200),
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    color: Colors.grey[400],
                    onPressed: onDecrement,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
