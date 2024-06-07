import 'package:flutter/material.dart';

class CustomSourceTitle extends StatelessWidget {
  const CustomSourceTitle(
      {super.key, required this.function, required this.text});
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        function();
      },
      dense: true,
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
