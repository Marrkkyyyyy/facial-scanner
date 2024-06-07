import 'package:get/get.dart';
import 'package:ugly/core/data/database_helper.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SQLHelper());
  }
}


