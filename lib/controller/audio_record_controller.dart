import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:ugly/core/services/services.dart';

class AudioRecordController extends GetxController {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  MyServices myServices = Get.find();
  bool isPaused = false;

  Map<String, String> audioPaths = {
    'Male': '',
    'Female': '',
    'Ugly': '',
    'Beautiful': '',
    'Happy': '',
    'Sad': '',
    'Deep-toned': '',
    'Light-toned': '',
  };

  List<String> gender = [
    'Male',
    'Female',
  ];
  List<String> rateFacial = [
    'Beautiful',
    'Ugly',
  ];
  List<String> emotion = [
    'Happy',
    'Sad',
  ];
  List<String> skinTone = [
    'Light-toned',
    'Deep-toned',
  ];

  void saveAudioPath(String path, String type) {
    myServices.sharedPreferences.setString(type, path);
  }

  String? getAudioPath(String type) {
    return myServices.sharedPreferences.getString(type);
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioPlayer.pause();
        await audioRecord.start();
        isRecording = true;
        update();
      } else {
        print("Permission denied for recording.");
      }
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> stopRecording(String type) async {
    try {
      String? path = await audioRecord.stop();
      if (path != null) {
        audioPaths[type] = path;
        isRecording = false;
        update();
      } else {
        print("Recording path is null.");
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> playRecording(String type) async {
    try {
      if (audioPlayer.state == PlayerState.playing) {
        await audioPlayer.pause();
      } else {
        String path = audioPaths[type]!;
        if (path.isNotEmpty) {
          Source urlSource = UrlSource(path);
          await audioPlayer.play(urlSource);
        } else {
          String? savedPath = getAudioPath(type);
          if (savedPath != null && savedPath.isNotEmpty) {
            Source urlSource = UrlSource(savedPath);
            await audioPlayer.play(urlSource);
          } else {
            EasyLoading.showError("No record saved", dismissOnTap: true);
          }
        }
      }
      update();
    } catch (e) {
      EasyLoading.showError("Error playing recording", dismissOnTap: true);
    }
  }

  void saveRecording(String type) {
    String audioPath = audioPaths[type]!;
    if (audioPath.isNotEmpty) {
      saveAudioPath(audioPath, type);
      audioPaths[type] = '';
      EasyLoading.showSuccess("Audio saved successfully", dismissOnTap: true);
      update();
      Get.back();
    } else {
      EasyLoading.showError("No audio recorded", dismissOnTap: true);
    }
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.state = PlayerState.completed;
      update();
    });
    audioRecord = Record();
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }
}
