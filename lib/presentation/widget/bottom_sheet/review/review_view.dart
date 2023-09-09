import 'package:flutter/material.dart';
import 'package:handover/presentation/screens/screens_extensions.dart';
import 'package:handover/presentation/widget/ratting_bar.dart';
import 'package:handover/presentation/widget/submit_button.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.screenHeightUnit() * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RatingBar(),
          SizedBox(
            height: context.screenHeightUnit() * 4,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidthUnit() * 4),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pickup Time",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text("10:00 PM")
              ],
            ),
          ),
          SizedBox(
            height: context.screenHeightUnit() * 1,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidthUnit() * 4),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Time",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text("10:00 PM")
              ],
            ),
          ),
          SizedBox(
            height: context.screenHeightUnit() * 4,
          ),
          Padding(
            padding: EdgeInsets.only(left: context.screenWidthUnit() * 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: context.screenHeightUnit() * 1,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$30.00",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SubmitButton(
                      text: "Submit",
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
