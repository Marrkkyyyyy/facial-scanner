import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ugly/controller/history_controller.dart';
import 'package:ugly/core/data/model/image_gender_model.dart';
import 'package:ugly/view/widget/confirmation_dialog.dart';
import 'package:ugly/view/widget/home/show_manipulate_custom_modal.dart';

class History extends StatelessWidget {
  History({super.key});
  final controller = Get.put(HistoryController());
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
          "History",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GetBuilder<HistoryController>(
                          builder: (controller) {
                        return ConfirmationDialog(
                            message:
                                "Are you sure you want to clear your recent pictures?",
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                            onConfirm: () async {
                              controller.clearHistory();
                              Navigator.of(context).pop();
                            });
                      });
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<HistoryController>(builder: (controller) {
        return controller.listImages.isEmpty
            ? Center(
                child: Text(
                  "No recent photos captured",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    children:
                        List.generate(controller.listImages.length, (index) {
                      ImageModel image = controller.listImages[index];
                      DateTime? date = DateTime.tryParse(image.dateCreated!);
                      String dateCreated =
                          DateFormat('MM/dd/yyyy hh:mma').format(date!);
                      double res = image.accuracy! * 100;
                      String accuracy = res.toStringAsFixed(1);
                      return GestureDetector(
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
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: controller.size.value.width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        color: Colors.black12,
                                        height:
                                            controller.size.value.height * .12,
                                        width:
                                            controller.size.value.width * .25,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4)),
                                          child: Image.file(
                                            File(image.image!),
                                            scale: 0.1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Positioned(
                                        left: controller.size.value.width * .27,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    image.prediction!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize: 18,
                                                            color: image.prediction ==
                                                                    "Female"
                                                                ? const Color
                                                                        .fromARGB(
                                                                    153,
                                                                    233,
                                                                    30,
                                                                    98)
                                                                : image.prediction ==
                                                                        "Male"
                                                                    ? Colors
                                                                        .blue
                                                                    : image.prediction ==
                                                                            "Happy"
                                                                        ? Colors
                                                                            .orange
                                                                        : image.prediction ==
                                                                                "Sad"
                                                                            ? Colors.red
                                                                            : image.prediction == "Ugly"
                                                                                ? Colors.brown
                                                                                : image.prediction == "Light-toned"
                                                                                    ? Colors.brown.shade200
                                                                                    : image.prediction == "Deep-toned"
                                                                                        ? Colors.brown.shade700
                                                                                        : Colors.teal,
                                                            fontWeight: FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                      Positioned(
                                        left: controller.size.value.width * .27,
                                        bottom: 0,
                                        child: Text(
                                          dateCreated,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.blueGrey),
                                        ),
                                      ),
                                      image.prediction == "Male" ||
                                              image.prediction == "Female"
                                          ? const SizedBox()
                                          : Align(
                                              alignment: Alignment.topRight,
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: accuracy,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              fontSize: 22,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                    ),
                                                    TextSpan(
                                                      text: "%",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList().reversed.toList(),
                  ),
                ),
              );
      }),
    );
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
