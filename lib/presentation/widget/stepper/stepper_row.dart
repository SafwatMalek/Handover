import 'package:flutter/material.dart';

class StepperRow extends StatelessWidget {
  final String text;
  final bool isActive;

  const StepperRow({Key? key, required this.isActive, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(height: 0.5,fontSize: 16),
        ),
      ],
    );
  }
}
