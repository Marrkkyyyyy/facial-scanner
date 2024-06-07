import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPhotoButton extends StatelessWidget {
  const CustomPhotoButton(
      {super.key,
      required this.function,
      required this.iconData,
      required this.text,
      required this.backgroundColor});
  final Function function;
  final IconData iconData;
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * .95, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        backgroundColor: backgroundColor,
      ),
      onPressed: () {
        function();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            iconData,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(text,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
