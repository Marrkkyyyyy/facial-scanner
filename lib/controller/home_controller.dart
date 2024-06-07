import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ugly/core/constant/routes.dart';
import 'package:ugly/core/data/database_helper.dart';
import 'package:ugly/core/data/model/image_gender_model.dart';
import 'package:ugly/core/services/services.dart';
import 'package:ugly/view/screen/scanner/all_classify_scanned_image.dart';
import 'package:ugly/view/screen/scanner/scanned_image.dart';
import 'package:ugly/view/widget/poor_result_dialog.dart';

class HomeController extends GetxController {
  SQLHelper controller = Get.find();
  RxList<ImageModel> listImages = RxList<ImageModel>([]);
  late AudioPlayer audioPlayer;
  MyServices myServices = Get.find();
  String audioPath = '';
  String genderLabel = '';
  String emotionLabel = '';
  String rateLabel = '';
  String skinLabel = '';
  double genderConfidence = 0.0;
  double emotionConfidence = 0.0;
  double skinConfidence = 0.0;
  double rateConfidence = 0.0;
  String insight = '';

  void showFullScreenImage(BuildContext context, String pickedImagePath) {
    Get.toNamed(AppRoute.fullScreenImage,
        arguments: {'pickedImagePath': pickedImagePath});
  }

  void removeImage(ImageModel image, String type) async {
    listImages.remove(image);
    await controller.removeImage(image, type);
    update();
  }

  String? getAudioPath(String type) {
    return myServices.sharedPreferences.getString(type);
  }

  Future<void> loadRecentImage() async {
    final List<Map<String, dynamic>> getAllImages =
        await SQLHelper.getAllDataOrderedByDate();
    listImages.assignAll(getAllImages
        .map((imageData) => ImageModel.fromJson(imageData))
        .toList());
    update();
  }

  final List<String> imagePaths = [
    'images/gender_detector.jpg',
    'images/rate_facial_attractiveness.png',
    'images/emotional_analysis.png',
    'images/skin_tone_detector.png',
  ];

  final List<String> title = [
    'Gender Detector',
    'Rate Facial Attractiveness',
    'Emotion Analysis',
    'Skin Tone Detector',
  ];
  var size = Rx<Size>(Size.zero);

  void pickCameraImage(context, bool isSpecific, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (isSpecific) {
        if (type == "gender") {
          loadGenderModel();
          classifyImage(pickedFile.path, context, type, true);
        } else if (type == "emotion") {
          loadEmotionModel();
          classifyImage(pickedFile.path, context, type, true);
        } else if (type == "rate") {
          loadRateModel();
          classifyImage(pickedFile.path, context, type, true);
        } else if (type == "skin") {
          loadSkinModel();
          classifyImage(pickedFile.path, context, type, true);
        }
      } else {
        bool loadingComplete = false;
        showDialog(
          barrierColor: const Color.fromARGB(176, 0, 0, 0),
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextt) {
            Future.delayed(const Duration(seconds: 4, milliseconds: 500), () {
              if (!loadingComplete) {
                Navigator.pop(contextt);
                if (genderLabel == 'Undefined' ||
                    rateLabel == 'Undefined' ||
                    emotionLabel == 'Undefined' ||
                    skinLabel == 'Undefined') {
                  showCustomDialog(context);
                } else {
                  showModalBottomSheet<dynamic>(
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return AllClassifyScannedImage(
                          rateConfidence: rateConfidence,
                          skinConfidence: skinConfidence,
                          skinLabel: skinLabel,
                          insight: insight,
                          genderConfidence: genderConfidence,
                          emotionConfidence: emotionConfidence,
                          genderLabel: genderLabel,
                          rateLabel: rateLabel,
                          emotionLabel: emotionLabel,
                          pickedImagePath: pickedFile.path,
                        );
                      });
                }
              }
            });
            return Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                animation: true,
                animationDuration: 3500,
                lineWidth: 12.0,
                percent: 1.0,
                center: Text(
                  "Analyzing...",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.black38,
                progressColor: Colors.teal,
              ),
            );
          },
        );
        loadGenderModel();
        allClassifyImage(
          pickedFile.path,
          context,
          "gender",
          false,
        );
        Future.delayed(const Duration(seconds: 1), () {
          loadEmotionModel();
          allClassifyImage(
            pickedFile.path,
            context,
            "emotion",
            false,
          );
          Future.delayed(const Duration(seconds: 1), () {
            loadRateModel();
            allClassifyImage(
              pickedFile.path,
              context,
              "rate",
              false,
            );
            Future.delayed(const Duration(seconds: 1), () {
              loadSkinModel();
              allClassifyImage(
                pickedFile.path,
                context,
                "skin",
                false,
              );
            });
          });
        });
      }
    }
  }

  void pickGalleryImage(context, bool isSpecific, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isSpecific) {
        if (type == "gender") {
          loadGenderModel();
          classifyImage(pickedFile.path, context, type, false);
        } else if (type == "emotion") {
          loadEmotionModel();
          classifyImage(pickedFile.path, context, type, false);
        } else if (type == "rate") {
          loadRateModel();
          classifyImage(pickedFile.path, context, type, false);
        } else if (type == "skin") {
          loadSkinModel();
          classifyImage(pickedFile.path, context, type, false);
        }
      } else {
        bool loadingComplete = false;
        showDialog(
          barrierColor: const Color.fromARGB(176, 0, 0, 0),
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextt) {
            Future.delayed(const Duration(seconds: 4, milliseconds: 500), () {
              if (!loadingComplete) {
                Navigator.pop(contextt);
                if (genderLabel == 'Undefined' ||
                    rateLabel == 'Undefined' ||
                    emotionLabel == 'Undefined' ||
                    skinLabel == 'Undefined') {
                  showCustomDialog(context);
                } else {
                  showModalBottomSheet<dynamic>(
                      isDismissible: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return AllClassifyScannedImage(
                          rateConfidence: rateConfidence,
                          skinConfidence: skinConfidence,
                          skinLabel: skinLabel,
                          insight: insight,
                          genderConfidence: genderConfidence,
                          emotionConfidence: emotionConfidence,
                          genderLabel: genderLabel,
                          rateLabel: rateLabel,
                          emotionLabel: emotionLabel,
                          pickedImagePath: pickedFile.path,
                        );
                      });
                }
              }
            });
            return Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                animation: true,
                animationDuration: 3000,
                lineWidth: 12.0,
                percent: 1.0,
                center: Text(
                  "Analyzing...",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.black38,
                progressColor: Colors.teal,
              ),
            );
          },
        );
        loadGenderModel();
        allClassifyImage(
          pickedFile.path,
          context,
          "gender",
          false,
        );
        Future.delayed(const Duration(seconds: 1), () {
          loadEmotionModel();
          allClassifyImage(
            pickedFile.path,
            context,
            "emotion",
            false,
          );
          Future.delayed(const Duration(seconds: 1), () {
            loadRateModel();
            allClassifyImage(
              pickedFile.path,
              context,
              "rate",
              false,
            );
            Future.delayed(const Duration(seconds: 1), () {
              loadSkinModel();
              allClassifyImage(
                pickedFile.path,
                context,
                "skin",
                false,
              );
            });
          });
        });
      }
    }
  }

  Future<void> loadGenderModel() async {
    await Tflite.loadModel(
        model: 'assets/gender_model.tflite',
        labels: 'assets/gender_labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  Future<void> loadEmotionModel() async {
    await Tflite.loadModel(
        model: 'assets/emotion_model.tflite',
        labels: 'assets/emotion_labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  Future<void> loadRateModel() async {
    await Tflite.loadModel(
        model: 'assets/rate_model.tflite',
        labels: 'assets/rate_labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  Future<void> loadSkinModel() async {
    await Tflite.loadModel(
        model: 'assets/skin_model.tflite',
        labels: 'assets/skin_labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  Future<void> allClassifyImage(
      String imagePath, mainContext, type, bool isCamera) async {
    var detector = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 0.0,
        imageStd: 200.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true);

    if (detector != null && detector.isNotEmpty) {
      var recognition = detector[0];

      String label = recognition['label'];
      double confidence = recognition['confidence'];
      await audioPlayer.pause();

      if (type == 'gender') {
        genderLabel = label;
        genderConfidence = confidence;
      } else if (type == 'emotion') {
        emotionLabel = label;
        emotionConfidence = confidence;
      } else if (type == 'skin') {
        skinLabel = label;
        skinConfidence = confidence;
      } else {
        if (label == 'Ugly') {
          rateConfidence = confidence;
          final Map<String, dynamic> getInsight =
              await SQLHelper.getRandomUglyInsight();
          rateLabel = label;
          insight = getInsight['insight'];
        } else {
          rateConfidence = confidence;
          final Map<String, dynamic> getInsight =
              await SQLHelper.getRandomBeautifulInsight();
          rateLabel = label;
          insight = getInsight['insight'];
        }
      }
    }
  }

  Future<void> classifyImage(
      String imagePath, mainContext, type, bool isCamera) async {
    var detector = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 0.0,
        imageStd: 200.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true);

    if (detector != null && detector.isNotEmpty) {
      var recognition = detector[0];

      String label = recognition['label'];
      double confidence = recognition['confidence'];
      await audioPlayer.pause();
      if (label == "Undefined") {
        showCustomDialog(mainContext);
      } else {
        if (type == "gender") {
          if (confidence > 0.70 && label != "Undefined") {
            final int imageID =
                await SQLHelper.insertGenderImage(imagePath, confidence, label);
            listImages.add(ImageModel(
                imageID: imageID.toString(),
                image: imagePath,
                accuracy: confidence,
                prediction: label,
                dateCreated: DateTime.now().toString(),
                insight: null));
            update();
            showModalBottomSheet<dynamic>(
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                context: mainContext,
                isScrollControlled: true,
                builder: (context) {
                  return ScannedImage(
                    mainContext: mainContext,
                    label: label,
                    confidence: confidence,
                    type: type,
                    isCamera: isCamera,
                    pickedImagePath: imagePath,
                  );
                }).then((_) {
              audioStop.value = true;
            });
            playRecording(label);
          } else {
            showCustomDialog(mainContext);
          }
        } else if (type == "emotion") {
          if (confidence > 0.70 && label != "Undefined") {
            final int imageID = await SQLHelper.insertEmotionImage(
                imagePath, confidence, label);
            listImages.add(ImageModel(
                imageID: imageID.toString(),
                image: imagePath,
                accuracy: confidence,
                prediction: label,
                dateCreated: DateTime.now().toString(),
                insight: null));
            update();
            showModalBottomSheet<dynamic>(
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                context: mainContext,
                isScrollControlled: true,
                builder: (context) {
                  return ScannedImage(
                    mainContext: mainContext,
                    label: label,
                    confidence: confidence,
                    type: type,
                    isCamera: isCamera,
                    pickedImagePath: imagePath,
                  );
                });
            playRecording(label);
          } else {
            showCustomDialog(mainContext);
          }
        } else if (type == "rate") {
          if (label == "Beautiful") {
            final Map<String, dynamic> insight =
                await SQLHelper.getRandomBeautifulInsight();
            final int imageID = await SQLHelper.insertRateImage(
                imagePath, confidence, label, insight['insight']);
            listImages.add(ImageModel(
                imageID: imageID.toString(),
                image: imagePath,
                accuracy: confidence,
                prediction: label,
                dateCreated: DateTime.now().toString(),
                insight: insight['insight']));
            update();
            showModalBottomSheet<dynamic>(
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                context: mainContext,
                isScrollControlled: true,
                builder: (context) {
                  return ScannedImage(
                    rate: confidence,
                    insight: insight['insight'],
                    mainContext: mainContext,
                    label: label,
                    confidence: confidence,
                    type: type,
                    isCamera: isCamera,
                    pickedImagePath: imagePath,
                  );
                });
            playRecording(label);
          } else {
            final Map<String, dynamic> insight =
                await SQLHelper.getRandomUglyInsight();
            final int imageID = await SQLHelper.insertRateImage(
                imagePath, confidence, label, insight['insight']);
            listImages.add(ImageModel(
                imageID: imageID.toString(),
                image: imagePath,
                accuracy: confidence,
                prediction: label,
                dateCreated: DateTime.now().toString(),
                insight: insight['insight']));
            update();
            showModalBottomSheet<dynamic>(
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                context: mainContext,
                isScrollControlled: true,
                builder: (context) {
                  return ScannedImage(
                    rate: confidence,
                    insight: insight['insight'],
                    mainContext: mainContext,
                    label: label,
                    confidence: confidence,
                    type: type,
                    isCamera: isCamera,
                    pickedImagePath: imagePath,
                  );
                });
            playRecording(label);
          }
        } else if (type == "skin") {
          if (confidence > 0.60 && label != "Undefined") {
            final int imageID =
                await SQLHelper.insertSkinImage(imagePath, confidence, label);
            listImages.add(ImageModel(
                imageID: imageID.toString(),
                image: imagePath,
                accuracy: confidence,
                prediction: label,
                dateCreated: DateTime.now().toString(),
                insight: null));
            update();
            showModalBottomSheet<dynamic>(
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                context: mainContext,
                isScrollControlled: true,
                builder: (context) {
                  return ScannedImage(
                    mainContext: mainContext,
                    label: label,
                    confidence: confidence,
                    type: type,
                    isCamera: isCamera,
                    pickedImagePath: imagePath,
                  );
                });
            playRecording(label);
          } else {
            showCustomDialog(mainContext);
          }
        }
      }
    }
  }

  RxBool audioStop = false.obs;
  Future<void> playRecording(String type, {int numberOfTimes = 1}) async {
    try {
      String? savedPath = getAudioPath(type);
      if (savedPath != null) {
        audioPath = savedPath;
        Source urlSource = UrlSource(audioPath);
        await audioPlayer.setSource(urlSource);
        Duration? duration = await audioPlayer.getDuration();
        audioStop.value = false;
        for (int i = 0; i < numberOfTimes; i++) {
          if (audioStop.value) {
            audioStop.value = false;
            break;
          }

          await audioPlayer.play(urlSource);
          await Future.delayed(Duration(
              seconds: duration!.inSeconds,
              milliseconds: duration.inMilliseconds));
          await audioPlayer.seek(Duration.zero);
        }
      } else {
        print("No audio path saved.");
      }
    } catch (e) {
      print("Error playing recording: $e");
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    disposeTfltte();
    super.dispose();
  }

  disposeTfltte() async {
    await Tflite.close();
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    loadRecentImage();

    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }
}
