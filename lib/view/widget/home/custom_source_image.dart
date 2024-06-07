import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/home_controller.dart';
import 'package:ugly/view/widget/home/custom_source_title.dart';

class CustomSourceImage extends StatelessWidget {
  CustomSourceImage(
      {super.key, required this.index, required this.mainContext});
  final int index;
  final controller = Get.find<HomeController>();
  final BuildContext mainContext;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      insetPadding: const EdgeInsets.all(0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSourceTitle(
                function: () {
                  Navigator.of(context).pop();
                  if (index == 0) {
                    controller.pickCameraImage(mainContext, true, "gender");
                  } else if (index == 1) {
                    controller.pickCameraImage(mainContext, true, "rate");
                  } else if (index == 2) {
                    controller.pickCameraImage(mainContext, true, "emotion");
                  } else if (index == 3) {
                    controller.pickCameraImage(mainContext, true, "skin");
                  }
                },
                text: "Take a photo"),
            const Divider(
              height: 0,
              color: Colors.black45,
            ),
            CustomSourceTitle(
                function: () {
                  Navigator.of(context).pop();
                  if (index == 0) {
                    controller.pickGalleryImage(mainContext, true, "gender");
                  } else if (index == 1) {
                    controller.pickGalleryImage(mainContext, true, "rate");
                  } else if (index == 2) {
                    controller.pickGalleryImage(mainContext, true, "emotion");
                  } else if (index == 3) {
                    controller.pickGalleryImage(mainContext, true, "skin");
                  }
                },
                text: "Gallery"),
          ],
        ),
      ),
    );
  }
}
