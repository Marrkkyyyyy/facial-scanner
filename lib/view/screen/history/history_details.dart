import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/history_controller.dart';
import 'package:ugly/view/widget/spacer_widget.dart';

class HistoryDetails extends StatelessWidget {
  HistoryDetails({super.key});
  final controller = Get.find<HistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 15),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          title: const Text(
            "Info",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "images/testimage.jpeg",
                height: controller.size.value.height * .4,
                width: controller.size.value.width,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SpacerWidget(),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.tableCellsLarge,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Type",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  Text(
                    "Emotion",
                    style: Theme.of(context).textTheme.headline5!,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
