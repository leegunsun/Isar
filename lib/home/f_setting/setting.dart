import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swf/firebase/fire_storage/fire_storage.dart';
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

  File? _image;
  final picker = ImagePicker();

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
          ),
          ElevatedButton(onPressed: (){
            // final f = Get.find<FireStorage>();
            // f.createString("data");
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PhysicsPainterDemo(),)
            );
          }, child: Text("test")),
          // FallingStringsWithWiper(),
        ],
      ),
    );
  }
}

class PhysicsPainterDemo extends StatefulWidget {
  @override
  _PhysicsPainterDemoState createState() => _PhysicsPainterDemoState();
}

class _PhysicsPainterDemoState extends State<PhysicsPainterDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _x = [50.0, 100.0, 150.0];
  final List<double> _y = [50.0, 100.0, 150.0];
  final List<double> _vx = [2.0, -2.5, 1.5];
  final List<double> _vy = [3.0, 1.5, -2.0];
  final double radius = 10.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
      setState(() {
        // 공 위치 업데이트
        for (int i = 0; i < _x.length; i++) {
          _x[i] += _vx[i];
          _y[i] += _vy[i];
        }

        // 벽과의 충돌 처리
        for (int i = 0; i < _x.length; i++) {
          if (_x[i] - radius < 0) {
            _x[i] = radius;
            _vx[i] = -_vx[i];
          } else if (_x[i] + radius > MediaQuery.of(context).size.width) {
            _x[i] = MediaQuery.of(context).size.width - radius;
            _vx[i] = -_vx[i];
          }
          if (_y[i] - radius < 0) {
            _y[i] = radius;
            _vy[i] = -_vy[i];
          } else if (_y[i] + radius > MediaQuery.of(context).size.height) {
            _y[i] = MediaQuery.of(context).size.height - radius;
            _vy[i] = -_vy[i];
          }
        }

        // 공들 간의 충돌 감지 및 처리
        for (int i = 0; i < _x.length; i++) {
          for (int j = i + 1; j < _x.length; j++) {
            double dx = _x[j] - _x[i];
            double dy = _y[j] - _y[i];
            double distance = sqrt(dx * dx + dy * dy);
            if (distance < 2 * radius) {
              // 충돌 발생
              double angle = atan2(dy, dx);
              double sinAngle = sin(angle);
              double cosAngle = cos(angle);

              // 기존 속도를 로컬 좌표로 변환
              double vx_i = _vx[i] * cosAngle + _vy[i] * sinAngle;
              double vy_i = _vy[i] * cosAngle - _vx[i] * sinAngle;
              double vx_j = _vx[j] * cosAngle + _vy[j] * sinAngle;
              double vy_j = _vy[j] * cosAngle - _vx[j] * sinAngle;

              // 속도 교환 (단순하게 동일 질량 가정)
              double temp = vx_i;
              vx_i = vx_j;
              vx_j = temp;

              // 다시 전역 좌표로 변환
              _vx[i] = vx_i * cosAngle - vy_i * sinAngle;
              _vy[i] = vy_i * cosAngle + vx_i * sinAngle;
              _vx[j] = vx_j * cosAngle - vy_j * sinAngle;
              _vy[j] = vy_j * cosAngle + vx_j * sinAngle;

              // 공이 겹치는 상황 방지
              double overlap = 2 * radius - distance;
              double halfOverlap = overlap / 2;
              _x[i] -= halfOverlap * cosAngle;
              _y[i] -= halfOverlap * sinAngle;
              _x[j] += halfOverlap * cosAngle;
              _y[j] += halfOverlap * sinAngle;
            }
          }
        }
      });
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PhysicsPainter(_x, _y, radius),
      child: Container(),
    );
  }
}

class PhysicsPainter extends CustomPainter {
  final List<double> x;
  final List<double> y;
  final double radius;

  PhysicsPainter(this.x, this.y, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    for (int i = 0; i < x.length; i++) {
      canvas.drawCircle(Offset(x[i], y[i]), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}