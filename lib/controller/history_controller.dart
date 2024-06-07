import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/home_controller.dart';
import 'package:ugly/core/data/database_helper.dart';
import 'package:ugly/core/services/services.dart';

import '../core/data/model/image_gender_model.dart';

class HistoryController extends GetxController {
  SQLHelper controller = Get.find();
  final homeController = Get.find<HomeController>();
  RxList<ImageModel> listImages = RxList<ImageModel>([]);
  late AudioPlayer audioPlayer;
  MyServices myServices = Get.find();
  String audioPath = '';
  void removeImage(ImageModel image, String type) async {
    listImages.remove(image);
    await controller.removeImage(image, type);
    homeController.loadRecentImage();
    update();
  }

  void clearHistory() async {
    await SQLHelper.deleteAllImages();
    listImages.clear();
    homeController.listImages.clear();
    update();
  }

  Future<void> loadRecentImage() async {
    final List<Map<String, dynamic>> getAllImages =
        await SQLHelper.getAllDataOrderedByDate();
    listImages.assignAll(getAllImages
        .map((imageData) => ImageModel.fromJson(imageData))
        .toList());
    update();
  }

  var size = Rx<Size>(Size.zero);
  @override
  void onInit() {
    loadRecentImage();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }
}
