import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swf/controller.dart';
import 'package:swf/user.dart';
import 'dart:math' as math;

void main() {
  Get.put(TestController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = [].obs;
  final c = Get.find<TestController>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(controller: controller,),
          Text('isar find sample'),
          Row(
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       c.upDate();
              //     },
              //     child: Text('upDate List')),
              ElevatedButton(
                  onPressed: () {
                    c.userModleUpDate();
                  },
                  child: Text('UserModelupDate List')),
              ElevatedButton(
                  onPressed: () {
                    c.findOne();
                  },
                  child: Text('find one')),
              // ElevatedButton(
              //     onPressed: () {
              //       c.findOne();
              //     },
              //     child: Text('TCfind one')),
            ],
          ),
          Text('isar create sample'),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    c.insert();
                  },
                  child: Text('insert one')),
              ElevatedButton(
                  onPressed: () {
                    c.insertTC();
                  },
                  child: Text('insertTC one')),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                c.delete();
              },
              child: Text('delete')),
          ElevatedButton(
              onPressed: () {
                c.insert();
              },
              child: Text('create')),
          ElevatedButton(
              onPressed: () {
                c.updateisar();
              },
              child: Text('update'))
          ,
          testContainer()
        ],
      ),
    );
  }

  Widget testContainer () {
    double fontSize = 20.0;
    return
        Container(
        color: Colors.redAccent,
        height: 100,
        width: 270,
        child: Center(
          child: CustomTextOverflowWidget(
            text: '8,888,888,888.888888888888888888',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        )
    );
  }
}


class CustomTextOverflowWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double maxWidth;
  final int minFractionDigits = 6; // 최소 소수점 자릿수
  final int maxFractionDigits = 18; // 최대 소수점 자릿수

  const CustomTextOverflowWidget({
    Key? key,
    required this.text,
    required this.style,
    this.maxWidth = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> parts = [];
    String integerPart = '';
    String fractionPart = '';
    // final parts = text.split('.');

    if(text.contains('.')) {
      parts = text.split('.');
      integerPart = '${parts[0]}.';
      fractionPart = parts[1];
    } else {
      integerPart = text;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(integerPart, style: style),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // 최대 가능한 길이부터 최소 길이까지 텍스트를 줄여가며 맞춰보기
              for (int i = maxFractionDigits; i >= minFractionDigits; i--) {
                var testText = fractionPart.substring(0, math.min(i, fractionPart.length));
                final textPainter = TextPainter(
                  text: TextSpan(text: testText, style: style),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: maxWidth);

                if (!textPainter.didExceedMaxLines) {
                  // 맞는 길이를 찾으면 해당 길이로 텍스트 설정
                  fractionPart = testText;
                  break;
                }
              }

              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  fractionPart.length > minFractionDigits ? '${fractionPart}...' : fractionPart,
                  style: style,
                  maxLines: 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

