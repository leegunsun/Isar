import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swf/main_style/main_style_color.dart';

enum SettingType {
  Userinfo;
}

class Setting extends StatefulWidget {
  Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  double? mediaWidth;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mediaWidth = Get.width;
  }

  final List<Widget> testList = List.generate(
    3,
    (index) {
      final List<String> testListInputText = ["Test1", "Test2", "Test3"];

      return Container(
        decoration: BoxDecoration(
          color: MainStyleColor.THEME_PRIMARY_LAVENDER,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Center(child: Text("${testListInputText[index]}")),
        ),
      );
    },
  );

  final List<Widget> testList2 = List.generate(
    3,
    (index) {
      final List<String> testListInputText = ["Test1", "Test2", "Test3"];

      return Container(
        decoration: BoxDecoration(
          color: MainStyleColor.THEME_PRIMARY_LAVENDER,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Center(child: Text("${testListInputText[index]}"))),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MainStyleColor.THEME_PRIMARY_LAVENDER,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("유저 이름"),
                      Text("UID"),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              height: 30,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return testList[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: testList.length),
            ),
          ),
          Text("작성중인 글"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              height: 130,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return testList2[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: testList2.length),
            ),
          ),
          Container(
            // height: 60,
            // width: 100,
            width: mediaWidth,
            color: MainStyleColor.THEME_PRIMARY_MINT_GREEN,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("유저 정보"),
            ),
          )
        ],
      ),
    );
  }
}
