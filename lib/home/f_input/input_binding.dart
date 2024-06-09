import 'package:get/get.dart';
import 'package:swf/home/f_input/input_contoller.dart';

class InputBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<InputController>(InputController());
  }
}