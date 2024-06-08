import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:swf/main_style/main_style_color.dart';

class InputView extends StatefulWidget {
  InputView({super.key});

  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> with WidgetsBindingObserver  {
// 초기화가 필요한 키들을 리스트로 정의합니다.
  List<String> keys = ["_author", "_publisher", "_content"];
  RxBool hasFocus = false.obs;
  double previousBottomInset = 0.0;

  Map<String, Map<String, dynamic>> createHandler = {};

  void addKey(String key) {
    createHandler[key] = {
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
    };
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
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final double bottomInset = View.of(context).viewInsets.bottom;
    final bool isKeyboardHidden = previousBottomInset > 0.0 && bottomInset == 0.0;

    if (isKeyboardHidden) {
      _runMyFunction();
    }

    previousBottomInset = bottomInset;
  }

  void _runMyFunction() {
    // 여기에서 원하는 작업을 수행합니다
    hasFocus.value = false;
  }

  Widget buildTextInputRow(
      {String? title,
      required String key,
      required TextInputAction textInputAction,
      bool needExpanded = false,
      bool needInnerTitle = false,
      InputDecoration? inputDecoration}) {
    final Map<String, dynamic>? findKey = createHandler[key];

    return buildRow(
        title: title,
        textEditingController: findKey?["controller"],
        focusNode: findKey?["focusNode"],
        textInputAction: textInputAction,
        inputDecoration: inputDecoration,
        needExpanded: needExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        hasFocus.value = false;
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              Visibility(
                visible: !hasFocus.value,
                child: Expanded(
                  flex: 1,
                  child: buildTextInputRow(
                      title: "저자",
                      key: "_author",
                      textInputAction: TextInputAction.next),
                ),
              ),
              Visibility(
                  visible: !hasFocus.value,
                  child: const SizedBox(height: 16.0)),
              Visibility(
                visible: !hasFocus.value,
                child: Expanded(
                  flex: 1,
                  child: buildTextInputRow(
                      title: "출판사",
                      key: "_publisher",
                      textInputAction: TextInputAction.next),
                ),
              ),
              Visibility(
                  visible: !hasFocus.value,
                  child: const SizedBox(height: 16.0)),
              Visibility(
                visible: !hasFocus.value,
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
                  visible: !hasFocus.value,
                  child: const SizedBox(height: 16.0)),
              Expanded(
                flex: 12,
                child: buildTextInputRow(
                  key: "_content",
                  textInputAction: TextInputAction.done,
                  inputDecoration: InputDecoration(
                    hintText: "내용을 입력하세요",
                    hintFadeDuration: const Duration(milliseconds: 300),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 3,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: MainStyleColor.THEME_PRIMARY_SKY_BLUE)),
                    focusedBorder: InputBorder.none,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  needExpanded: true,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // 제출 버튼에 대한 동작 추가
                },
                child: const Text('저장하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow({
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required TextInputAction textInputAction,
    String? title,
    InputDecoration? inputDecoration,
    required bool needExpanded,
  }) {
    final int? widgetMaxLines = needExpanded ? null : 1;
    final int? widgetMaxLength = needExpanded ? null : 15;
    final TextInputType widgetTextInputType =
        needExpanded ? TextInputType.multiline : TextInputType.text;

    return Row(
      children: [
        if (title != null) SizedBox(width: 80, child: Text(title)),
        Expanded(
          child: TextFormField(
            focusNode: focusNode,
            controller: textEditingController,
            expands: needExpanded,
            maxLines: widgetMaxLines,
            maxLength: widgetMaxLength,
            decoration: inputDecoration ??
                InputDecoration(
                  counterText: "",
                  hintText: "$title를 입력하세요",
                ),
            keyboardType: widgetTextInputType,
            textInputAction: textInputAction,
            onTap: () {
              if (needExpanded) {
                hasFocus.value = true;
              } else {
                hasFocus.value = false;
              }
            },
          ),
        ),
      ],
    );
  }
}

class StarRatingWidget extends StatefulWidget {
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _rating = 0;

  void _onStarTapped(int index) {
    setState(() {
      _rating = index + 1;
    });
  }

  Widget _buildStar(int index) {
    IconData icon = index < _rating ? Icons.star : Icons.star_border;
    return GestureDetector(
      onTap: () => _onStarTapped(index),
      child: Icon(
        icon,
        color: index < _rating ? MainStyleColor.THEME_PRIMARY_SOFT_PINK : MainStyleColor.THEME_PRIMARY_SKY_BLUE,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
