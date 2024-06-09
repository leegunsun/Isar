import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swf/main_style/main_style_color.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

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
          child: AspectRatio(aspectRatio: 3/2 ,child: Center(child: Text("${testListInputText[index]}"))),
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
                  width: 100,
                  height: 100,
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
        ],
      ),
    );
  }
}
