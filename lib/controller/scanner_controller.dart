import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/core/constant/routes.dart';

class ScannerController extends GetxController {
  var size = Rx<Size>(Size.zero);
  @override
  void onInit() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  void showFullScreenImage(BuildContext context, String pickedImagePath) {
    Get.toNamed(AppRoute.fullScreenImage,
        arguments: {'pickedImagePath': pickedImagePath});
  }
}
