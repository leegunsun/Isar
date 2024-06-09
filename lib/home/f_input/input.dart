import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:swf/home/f_input/f_w_input/f_w_input_field.dart';
import 'package:swf/main_style/main_style_color.dart';

import 'f_w_input/f_w_star.dart';
import 'input_binding.dart';
import 'input_contoller.dart';

class InputView extends StatefulWidget {
  InputView({super.key});

  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> with WidgetsBindingObserver {
  final controller = Get.find<InputController>();

  // 초기화가 필요한 키들을 리스트로 정의합니다.
  List<String> keys = ["_author", "_publisher", "_content"];
  double previousBottomInset = 0.0;

  Map<String, Map<String, dynamic>> createHandler = {};

  void addKey(String key) {
    createHandler[key] = {
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
    };
  }

  Map<String, dynamic>? _findKey(String key) {
    return createHandler[key];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    for (var key in keys) {
      addKey(key);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    createHandler.forEach((key, value) {
      value["controller"]?.dispose();
      value["focusNode"]?.dispose();
    });
    Get.delete<InputController>();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final double bottomInset = View.of(context).viewInsets.bottom;
    final bool isKeyboardHidden =
        previousBottomInset > 0.0 && bottomInset == 0.0;

    if (isKeyboardHidden) {
      _runMyFunction();
    }

    previousBottomInset = bottomInset;
  }

  void _runMyFunction() {
    controller.hasFocus.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        controller.hasFocus.value = false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // SliverPadding(
            //   padding: EdgeInsets.all(16.0),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //         return Obx(() {
            //           return Column(
            //             children: [
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: CreateInputField(
            //                   title: "저자",
            //                   mapKey: _findKey("_author"),
            //                   textInputAction: TextInputAction.next,
            //                 ),
            //               ),
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: const SizedBox(height: 16.0),
            //               ),
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: CreateInputField(
            //                   title: "출판사",
            //                   mapKey: _findKey("_publisher"),
            //                   textInputAction: TextInputAction.next,
            //                 ),
            //               ),
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: const SizedBox(height: 16.0),
            //               ),
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const SizedBox(width: 80, child: Text("평점")),
            //                     StarRatingWidget(),
            //                   ],
            //                 ),
            //               ),
            //               Visibility(
            //                 visible: !controller.hasFocus.value,
            //                 child: const SizedBox(height: 16.0),
            //               ),
            //             ],
            //           );
            //         });
            //       },
            //       childCount: 1,
            //     ),
            //   ),
            // ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: Expanded(
                flex: 1,
                child: CreateInputField(
                  title: "저자",
                  mapKey: _findKey("_author"),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: const SizedBox(height: 16.0),
            ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: Expanded(
                flex: 1,
                child: CreateInputField(
                  title: "출판사",
                  mapKey: _findKey("_publisher"),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: const SizedBox(height: 16.0),
            ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 80, child: Text("평점")),
                    StarRatingWidget(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !controller.hasFocus.value,
              child: const SizedBox(height: 16.0),
            ),
            Expanded(flex:12,child: buildExpanded()),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('저장하기'),
            ),
            // SliverPadding(
            //   padding: const EdgeInsets.all(16.0),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //         return Obx(() {
            //           return Column(
            //             children: [
            //               buildExpanded(),
            //               const SizedBox(height: 16.0),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 child: const Text('저장하기'),
            //               ),
            //             ],
            //           );
            //         });
            //       },
            //       childCount: 1,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildExpanded() {
    return CreateInputField(
      mapKey: _findKey("_content"),
      textInputAction: TextInputAction.done,
      inputDecoration: InputDecoration(
        hintText: "내용을 입력하세요",
        hintFadeDuration: const Duration(milliseconds: 300),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 3,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: MainStyleColor.THEME_PRIMARY_SKY_BLUE,
          ),
        ),
        focusedBorder: InputBorder.none,
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.all(10),
      ),
      needExpanded: true,
    );
  }

}
