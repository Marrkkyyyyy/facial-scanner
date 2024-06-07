import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ugly/controller/home_controller.dart';
import 'package:ugly/core/data/model/image_gender_model.dart';
import 'package:ugly/view/widget/home/custom_recent.dart';
import 'package:ugly/view/widget/home/show_manipulate_custom_modal.dart';

class CustomRecentCaptured extends StatelessWidget {
  CustomRecentCaptured({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Obx(() {
        return controller.listImages.isEmpty
            ? Center(
                child: Text("No recent photos captured",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontStyle: FontStyle.italic)))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRecent(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                            children: List.generate(
                                controller.listImages.length >= 10
                                    ? 10
                                    : controller.listImages.length, (index) {
                          int reversedIndex =
                              controller.listImages.length - 1 - index;
                          ImageModel image =
                              controller.listImages[reversedIndex];

                          return Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: GestureDetector(
                              onLongPress: () {
                                String type = '';
                                if (image.prediction == 'Ugly' ||
                                    image.prediction == 'Beautiful') {
                                  type = 'rate';
                                } else if (image.prediction == 'Sad' ||
                                    image.prediction == 'Happy') {
                                  type = 'emotion';
                                } else {
                                  type = 'gender';
                                }
                                showCustomModal(context, image, type);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Scanned(
                                                pickedImagePath: image.image!,
                                                label: image.prediction!,
                                                confidence: image.accuracy!,
                                                insight: image.insight ?? '',
                                              );
                                            });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueGrey,
                                        radius: 38,
                                        backgroundImage: FileImage(
                                            File(image.image!),
                                            scale: 0.1),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      image.prediction == 'Deep-toned'
                                          ? "Deep"
                                          : image.prediction == 'Light-toned'
                                              ? "Light"
                                              : "${image.prediction}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: image.prediction ==
                                                      "Female"
                                                  ? const Color.fromARGB(
                                                      153, 233, 30, 98)
                                                  : image.prediction == "Male"
                                                      ? Colors.blue
                                                      : image.prediction ==
                                                              "Happy"
                                                          ? Colors.orange
                                                          : image.prediction ==
                                                                  "Sad"
                                                              ? Colors.red
                                                              : image.prediction ==
                                                                      "Ugly"
                                                                  ? Colors.brown
                                                                  : image.prediction ==
                                                                          "Light-toned"
                                                                      ? Colors
                                                                          .brown
                                                                          .shade200
                                                                      : image.prediction ==
                                                                              "Deep-toned"
                                                                          ? Colors
                                                                              .brown
                                                                              .shade700
                                                                          : Colors
                                                                              .teal),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList())
                      ],
                    ),
                  ),
                ],
              );
      });
    });
  }

  showCustomModal(BuildContext context, ImageModel image, String type) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ShowManipulateCustomModal(onRemove: () {
            controller.removeImage(image, type);
            Navigator.of(context).pop();
          });
        });
  }
}

class Scanned extends StatelessWidget {
  const Scanned(
      {super.key,
      required this.pickedImagePath,
      required this.label,
      required this.confidence,
      required this.insight});
  final String pickedImagePath;
  final String label;
  final double confidence;
  final String insight;

  @override
  Widget build(BuildContext context) {
    double res = 0.0;
    res = (confidence * 100);
    String accuracy = res.toStringAsFixed(2);

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.57),
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
                    // controller.showFullScreenImage(context, pickedImagePath);
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
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 12,
              thickness: .8,
            ),
            label == "Ugly" || label == "Beautiful"
                ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 8),
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
                        const SizedBox(
                          height: 8,
                        ),
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
                  )
                : label == "Female" || label == "Male"
                    ? const SizedBox()
                    : Padding(
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
                      ),
          ],
        ),
      ),
    );
  }
}
