import 'package:flutter/material.dart';
import 'package:handover/presentation/widget/stepper/stepper_row.dart';

import 'stepper_steps.dart';

class StepperComponent extends StatelessWidget {
  final List<Steps> steps;
  final double paddingHorizontal;

  const StepperComponent(
      {Key? key, required this.steps, required this.paddingHorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Column(
        children: List.generate(steps.length, (index) {
          var step = steps[index];
          var isActive = step.state == StepsState.active ||
              step.state == StepsState.complete;
          var row = StepperRow(isActive: isActive, text: step.text);
          if (index < steps.length - 1) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  row,
                  Container(
                    height: 24,
                    width: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                    color: step.state == StepsState.complete
                        ? Colors.black
                        : Colors.white,
                  ),
                ]);
          }
          return row;
        }),
      ),
    );
  }
}
