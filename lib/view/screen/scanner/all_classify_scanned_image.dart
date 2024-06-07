import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ugly/controller/home_controller.dart';

class AllClassifyScannedImage extends StatelessWidget {
  const AllClassifyScannedImage(
      {super.key,
      required this.pickedImagePath,
      required this.emotionLabel,
      required this.genderLabel,
      required this.rateLabel,
      required this.insight,
      required this.genderConfidence,
      required this.emotionConfidence,
      required this.skinLabel,
      required this.skinConfidence,
      required this.rateConfidence});
  final String pickedImagePath;
  final String emotionLabel;
  final String genderLabel;
  final String rateLabel;
  final String skinLabel;
  final String insight;
  final double genderConfidence;
  final double emotionConfidence;
  final double rateConfidence;
  final double skinConfidence;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    double res1 = (emotionConfidence * 100);
    String emotionAccuracy = res1.toStringAsFixed(2);
    double res2 = (skinConfidence * 100);
    String skinAccuracy = res2.toStringAsFixed(2);
    double res3 = (rateConfidence * 100);
    String rateAccuracy = res3.toStringAsFixed(2);
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
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
              height: 4,
            ),
            Text(
              genderLabel,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 12,
              thickness: .8,
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 8, left: 12),
              child: LinearPercentIndicator(
                leading: SizedBox(
                  width: 95,
                  child: Text(
                    rateLabel == 'Beautiful' && genderLabel == "Male"
                        ? "Handsome"
                        : rateLabel,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ),
                animation: true,
                lineHeight: 25.0,
                animationDuration: 400,
                percent: rateConfidence,
                barRadius: const Radius.circular(20),
                center: Text(
                  "$rateAccuracy%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
                progressColor: Colors.teal,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 8, left: 12),
              child: LinearPercentIndicator(
                leading: SizedBox(
                  width: 95,
                  child: Text(
                    emotionLabel,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange),
                  ),
                ),
                animation: true,
                lineHeight: 25.0,
                animationDuration: 400,
                percent: emotionConfidence,
                barRadius: const Radius.circular(20),
                center: Text(
                  "$emotionAccuracy%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
                progressColor: Colors.teal,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 8, left: 12),
              child: LinearPercentIndicator(
                leading: SizedBox(
                  width: 95,
                  child: Text(
                    skinLabel == "Light-toned"
                        ? "Light"
                        : skinLabel == "Deep-toned"
                            ? "Deep"
                            : skinLabel,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: skinLabel == "Light-toned"
                            ? Colors.brown.shade200
                            : skinLabel == "Deep-toned"
                                ? Colors.brown.shade700
                                : Colors.brown),
                  ),
                ),
                animation: true,
                lineHeight: 25.0,
                animationDuration: 400,
                percent: skinConfidence,
                barRadius: const Radius.circular(20),
                center: Text(
                  "$skinAccuracy%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ),
                progressColor: Colors.teal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 12, left: 12),
              child: Text(
                insight,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline5!.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
