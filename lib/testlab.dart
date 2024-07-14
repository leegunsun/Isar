import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:swf/controller.dart';
import 'package:swf/rive/rivelab.dart';

class TestLab extends StatefulWidget {
  TestLab({super.key});

  @override
  State<TestLab> createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> {

  final List<Widget> testLab = [
    RiveLab(),
    TestReplace()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: testLab.map((e) => ElevatedButton(onPressed: (){
            Get.to(() => e, routeName: e.toString());
          }, child: Text("GO to ${e.runtimeType}"))).toList(),
        ),
      ),
    );
  }
}

class TestReplace extends StatelessWidget {
  const TestReplace({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestController>();

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.testValue.value++;
                    },
                    child: Text("value++"),),
                    Text("test Value => ${controller.testValue.value}"),
            // GetX<TestController>(
            //     init: TestController(),
            //     builder: (controller) {
            //   return Text("init: TestController() => ${controller.testValue.value}");
            // }),
            // GetX<TestController>(
            //   init: Get.isRegistered<TestController>()
            //       ? Get.find<TestController>()
            //       : Get.put(TestController()),
            //   builder: (controller) {
            //     return Text("Get.find<TestController> => ${controller.testValue.value}");
            //   },
            // ),

            GetX<TestController>(
                builder: (controller) {
                  final controller2 = Get.find<TestController>();
                  return Text("final controller2 = Get.find<TestController>(); => ${controller2.testValue.value}");
                }),
                ],
              );
            }),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // Get.reset();
                Get.replace(TestController());
                // Get.replace 이후에 새로운 controller를 찾도록 상태를 재빌드
                Get.forceAppUpdate();
              },
              child: Text("RePlace"),
            ),
          ],
        ),
      ),
    );
  }
}