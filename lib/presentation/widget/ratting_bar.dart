import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int starCount;
  final double rating;
  final double size;
  final Color color;
  final Color unratedColor;

  const RatingBar(
      {Key? key,
      this.starCount = 5,
      this.rating = 0.0,
      this.size = 36,
      this.color = Colors.yellow,
      this.unratedColor = Colors.white})
      : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1;
            });
          },
          child: Icon(Icons.star_rounded,
              size: widget.size,
              color: index < _currentRating.toInt()
                  ? widget.color
                  : widget.unratedColor),
        );
      }),
    );
  }
}
