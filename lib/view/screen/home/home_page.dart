import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/home_controller.dart';
import 'package:ugly/core/constant/color.dart';
import 'package:ugly/view/widget/home/custom_header.dart';
import 'package:ugly/view/widget/home/custom_list_module.dart';
import 'package:ugly/view/widget/home/custom_photo_button.dart';
import 'package:ugly/view/widget/home/custom_recent_captured.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(size: controller.size.value),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomRecentCaptured(),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListModule(),
                ]),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPhotoButton(
                  function: () {
                    controller.pickCameraImage(context, false, "");
                  },
                  iconData: FontAwesomeIcons.camera,
                  text: "Take a Photo",
                  backgroundColor: const Color.fromARGB(235, 33, 137, 207)),
              const SizedBox(
                height: 2,
              ),
              CustomPhotoButton(
                function: () {
                  controller.pickGalleryImage(context, false, "");
                },
                iconData: FontAwesomeIcons.image,
                text: "Pick from Gallery",
                backgroundColor: const Color.fromARGB(210, 39, 84, 180),
              )
            ],
          ),
        ));
  }
}
