import 'package:flutter/material.dart';
import 'package:handover/presentation/screens/screens_extensions.dart';

class SubmitButton extends StatelessWidget {
  final String text;

  const SubmitButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidthUnit() * 4,
          vertical: context.screenHeightUnit() * 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.screenWidthUnit() * 4),
              bottomLeft: Radius.circular(context.screenWidthUnit() * 4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: context.screenWidthUnit() * 4,
          ),
          const Icon(
            Icons.arrow_forward,
            size: 16,
          ),
        ],
      ),
    );
  }
}
