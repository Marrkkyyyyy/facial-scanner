import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugly/controller/audio_record_controller.dart';
import 'package:ugly/view/widget/home/set_record.dart';
import 'package:ugly/view/widget/spacer_widget.dart';

class AudioRecord extends StatelessWidget {
  const AudioRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AudioRecordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Audio"),
      ),
      body: GetBuilder<AudioRecordController>(builder: (controller) {
        return Column(
          children: [
            const SpacerWidget(),
            GestureDetector(
              onTap: () {
                showDialog<dynamic>(
                    context: context,
                    builder: (context) {
                      return SetRecord(
                        controller: controller,
                        type: "gender",
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Gender Detector",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18, color: Colors.blue),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const SpacerWidget(),
            GestureDetector(
              onTap: () {
                showDialog<dynamic>(
                    context: context,
                    builder: (context) {
                      return SetRecord(
                        controller: controller,
                        type: "rate",
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rate Facial Attractiveness",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18, color: Colors.blue),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const SpacerWidget(),
            GestureDetector(
              onTap: () {
                showDialog<dynamic>(
                    context: context,
                    builder: (context) {
                      return SetRecord(
                        controller: controller,
                        type: "emotion",
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Emotion Analysis",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18, color: Colors.blue),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const SpacerWidget(),
            GestureDetector(
              onTap: () {
                showDialog<dynamic>(
                    context: context,
                    builder: (context) {
                      return SetRecord(
                        controller: controller,
                        type: "skin",
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Skin Tone Detector",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 18, color: Colors.blue),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
