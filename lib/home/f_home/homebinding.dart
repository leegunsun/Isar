import 'package:get/get.dart';
import 'package:swf/home/f_home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}