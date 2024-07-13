import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swf/rive/rivelab.dart';

class TestLab extends StatefulWidget {
  TestLab({super.key});

  @override
  State<TestLab> createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> {

  final List<Widget> testLab = [
    RiveLab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: testLab.map((e) => ElevatedButton(onPressed: (){
            Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(builder: (context) => e);
              },
            );
          }, child: Text("GO to ${e.runtimeType}"))).toList(),
        ),
      ),
    );
  }
}
