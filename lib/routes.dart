import 'package:get/get.dart';
import 'package:ugly/core/constant/routes.dart';
import 'package:ugly/view/screen/history/history.dart';
import 'package:ugly/view/screen/history/history_details.dart';
import 'package:ugly/view/screen/home/audio_record.dart';
import 'package:ugly/view/screen/home/home_page.dart';
import 'package:ugly/view/screen/scanner/fullscreen_image.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => HomePage()),
  GetPage(
      name: AppRoute.history,
      page: () => History(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150)),
  GetPage(
    name: AppRoute.fullScreenImage,
    page: () => const FullScreenImage(),
  ),
  GetPage(
    name: AppRoute.historyDetails,
    page: () => HistoryDetails(),
  ),
  GetPage(
    name: AppRoute.audioRecord,
    page: () => const AudioRecord(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 150),
  ),
];
