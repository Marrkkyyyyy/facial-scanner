import 'package:flutter/material.dart';

class SpacerWidget extends StatelessWidget {
  const SpacerWidget(
      {super.key,
      this.height = 10,
      this.color = const Color.fromARGB(115, 235, 235, 235)});
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
