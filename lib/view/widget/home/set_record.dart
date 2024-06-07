import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/audio_record_controller.dart';

class SetRecord extends StatelessWidget {
  const SetRecord({super.key, required this.controller, required this.type});
  final AudioRecordController controller;
  final String type;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioRecordController>(builder: (controller) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Set audio",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  type == "skin"
                      ? "Skin Tone Detector"
                      : type == "gender"
                          ? "Gender Detector"
                          : type == "rate"
                              ? "Rate Facial Attractiveness"
                              : "Emotion Analysis",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black54, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: List.generate(
                    type == 'gender'
                        ? controller.gender.length
                        : type == 'skin'
                            ? controller.skinTone.length
                            : type == 'rate'
                                ? controller.rateFacial.length
                                : controller.emotion.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Set(
                              type: type == 'gender'
                                  ? controller.gender[index]
                                  : type == 'skin'
                                      ? controller.skinTone[index]
                                      : type == 'rate'
                                          ? controller.rateFacial[index]
                                          : controller.emotion[index],
                            );
                          });
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type == 'gender'
                                ? controller.gender[index]
                                : type == 'skin'
                                    ? controller.skinTone[index]
                                    : type == 'rate'
                                        ? controller.rateFacial[index]
                                        : controller.emotion[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.black45,
                                    fontStyle: FontStyle.italic),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black87,
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       onPressed: controller.isRecording
                          //           ? () {
                          //               controller.stopRecording(type);
                          //             }
                          //           : () {
                          //               controller.startRecording();
                          //             },
                          //       color: Colors.blue,
                          //       icon: Icon(
                          //         controller.isRecording ? Icons.stop : Icons.mic,
                          //         size: 32,
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         if (controller.isRecording) {
                          //           controller.stopRecording(type);
                          //         } else {
                          //           controller.playRecording(type);
                          //         }
                          //       },
                          //       color: Colors.blue,
                          //       icon: Icon(
                          //         controller.audioPlayer.state ==
                          //                 PlayerState.playing
                          //             ? Icons.pause
                          //             : Icons.play_circle_fill,
                          //         size: 32,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              // const SizedBox(
              //   height: 4,
              // ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       TextButton(
              //         onPressed: () async {
              //           if (controller.isRecording) {
              //             await controller.audioRecord.stop();
              //             controller.isRecording = false;
              //             controller.update();
              //           } else if (controller.audioPlayer.state ==
              //               PlayerState.playing) {
              //             await controller.audioPlayer.pause();
              //           }
              //           Navigator.of(context).pop();
              //         },
              //         style: ButtonStyle(
              //           foregroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white),
              //           backgroundColor:
              //               MaterialStateProperty.all<Color>(Colors.black38),
              //         ),
              //         child: const Text("Cancel"),
              //       ),
              //       const SizedBox(
              //         width: 6,
              //       ),
              //       TextButton(
              //         onPressed: () async {
              //           if (controller.isRecording) {
              //             controller.stopRecording(type);
              //           }
              //           await controller.audioPlayer.pause();
              //           controller.saveRecording(type);
              //         },
              //         style: ButtonStyle(
              //           foregroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white),
              //           backgroundColor:
              //               MaterialStateProperty.all<Color>(Colors.blue),
              //         ),
              //         child: const Text("Set"),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}

class Set extends StatelessWidget {
  const Set({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioRecordController>();
    return GetBuilder<AudioRecordController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 4, left: 8, right: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              type,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.isRecording
                    ? () {
                        controller.stopRecording(type);
                      }
                    : () {
                        controller.startRecording();
                      },
                color: Colors.blue,
                icon: Icon(
                  controller.isRecording ? Icons.stop : Icons.mic,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (controller.isRecording) {
                    controller.stopRecording(type);
                  } else {
                    controller.playRecording(type);
                  }
                },
                color: Colors.blue,
                icon: Icon(
                  controller.audioPlayer.state == PlayerState.playing
                      ? Icons.pause
                      : Icons.play_circle_fill,
                  size: 32,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    if (controller.isRecording) {
                      await controller.audioRecord.stop();
                      controller.isRecording = false;
                      controller.update();
                    } else if (controller.audioPlayer.state ==
                        PlayerState.playing) {
                      await controller.audioPlayer.pause();
                    }
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black38),
                  ),
                  child: const Text("Cancel"),
                ),
                const SizedBox(
                  width: 6,
                ),
                TextButton(
                  onPressed: () async {
                    if (controller.isRecording) {
                      controller.stopRecording(type);
                    }
                    await controller.audioPlayer.pause();
                    controller.saveRecording(type);
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text("Set"),
                ),
              ],
            ),
          ),
        ]),
      );
    });
  }
}
