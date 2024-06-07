import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/routes.dart';

class CustomRecent extends StatelessWidget {
  const CustomRecent({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recent",
            style: Theme.of(context).textTheme.headline5!,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.history);
            },
            child: Text(
              "See all",
              style: Theme.of(context).textTheme.headline5!,
            ),
          ),
        ],
      ),
    );
  }
}
