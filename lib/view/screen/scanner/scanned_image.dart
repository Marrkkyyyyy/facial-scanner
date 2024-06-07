import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/home_controller.dart';
import 'package:ugly/controller/scanner_controller.dart';

class ScannedImage extends StatelessWidget {
  ScannedImage({
    super.key,
    required this.isCamera,
    required this.pickedImagePath,
    required this.type,
    required this.confidence,
    required this.label,
    required this.mainContext,
    this.insight = '',
    this.rate = 0.0,
  });
  final controller = Get.put(ScannerController());
  final homeController = Get.find<HomeController>();
  final bool isCamera;
  final String pickedImagePath;
  final String type;
  final double confidence;
  final String label;
  final BuildContext mainContext;
  final String insight;
  final double rate;
  @override
  Widget build(BuildContext context) {
    double res = (confidence * 100);
    String accuracy = res.toStringAsFixed(2);
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: type == 'gender' || type == 'emotion' || type == 'skin'
                ? MediaQuery.of(context).size.height * 0.61
                : MediaQuery.of(context).size.height * 0.72),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 15),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 224, 224),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 130,
              child: Hero(
                tag: pickedImagePath,
                child: GestureDetector(
                  onTap: () {
                    controller.showFullScreenImage(context, pickedImagePath);
                  },
                  child: ClipOval(
                    child: Image.file(
                      File(pickedImagePath),
                      fit: BoxFit.cover,
                      width: 250,
                      height: 250,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: controller.size.value.width * .9,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 12,
              thickness: .8,
            ),
            type == "gender"
                ? const SizedBox()
                : type == "emotion" || type == 'skin'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12, top: 8),
                        child: LinearPercentIndicator(
                          trailing: Text(
                            "Accuracy",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 16),
                          ),
                          animation: true,
                          lineHeight: 25.0,
                          animationDuration: 400,
                          percent: confidence,
                          barRadius: const Radius.circular(20),
                          center: Text(
                            "$accuracy%",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white),
                          ),
                          progressColor: Colors.teal,
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12, top: 8),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 25.0,
                              animationDuration: 400,
                              percent: confidence,
                              barRadius: const Radius.circular(20),
                              center: Text(
                                "$accuracy%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                              progressColor: Colors.teal,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12, top: 8),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8),
                                  child: Text(
                                    insight,
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .95, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: isCamera
                      ? const Color.fromARGB(235, 33, 137, 207)
                      : const Color.fromARGB(221, 39, 84, 180),
                ),
                onPressed: isCamera
                    ? () {
                        Navigator.of(context).pop();
                        homeController.pickCameraImage(mainContext, true, type);
                      }
                    : () {
                        Navigator.of(context).pop();
                        homeController.pickGalleryImage(
                            mainContext, true, type);
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      isCamera
                          ? FontAwesomeIcons.camera
                          : FontAwesomeIcons.image,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(isCamera ? "Retake" : "Select Another Image",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
