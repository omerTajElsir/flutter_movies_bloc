import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    Key key,
    @required this.value,
  }) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    Color color = Colors.yellow.shade700;
    if (value == 10) {
      for (int i = 0; i < 5; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
    } else if (value == 9) {
      for (int i = 0; i < 4; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
    } else if (value == 8) {
      for (int i = 0; i < 4; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 7) {
      for (int i = 0; i < 3; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 6) {
      for (int i = 0; i < 3; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 5) {
      for (int i = 0; i < 2; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 4) {
      for (int i = 0; i < 2; i++)
        stars.add(Icon(
          Icons.star,
          color: color,
        ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 3) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else if (value == 2) {
      stars.add(Icon(
        Icons.star,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    } else {
      stars.add(Icon(
        Icons.star_half,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
      stars.add(Icon(
        Icons.star_border,
        color: color,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}