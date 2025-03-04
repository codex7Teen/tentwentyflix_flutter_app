import 'package:flutter/material.dart';

class CustomMovieSeatWidget extends StatelessWidget {
  final Color color;
  const CustomMovieSeatWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0.8,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 14,
          width: 19,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Container(
          height: 4,
          width: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}
