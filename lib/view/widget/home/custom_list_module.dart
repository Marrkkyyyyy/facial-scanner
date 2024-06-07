import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/home_controller.dart';

import 'custom_source_image.dart';

class CustomListModule extends StatelessWidget {
  CustomListModule({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () async {
            showDialog(
                context: context,
                builder: (contextt) {
                  return CustomSourceImage(
                    mainContext: context,
                    index: index,
                  );
                });
          },
          child: Card(
              child: Column(
            children: [
              Image.asset(
                controller.imagePaths[index],
                height: MediaQuery.of(context).size.height * .13,
              ),
              Text(
                controller.title[index],
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          )),
        );
      },
    );
  }
}
