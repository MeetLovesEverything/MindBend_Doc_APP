import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}