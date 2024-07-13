import 'package:flutter/material.dart';
import 'package:swf/home/f_input/f_w_input/f_w_star.dart';
import 'package:swf/rive/artboardnestedinputs.dart';
import 'package:swf/rive/event_star_rating.dart';
import 'package:swf/rive/state_machine_skills.dart';

class TestLab extends StatelessWidget {
  TestLab({super.key});

  final List<Widget> listWidget = [
   const ArtboardNestedInputs(), 
    const StateMachineSkills(),
    const EventStarRating()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listWidget.map((e) => ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return e;
              }));
            }, child: Text("Go to $e"))).toList(),
          ),
        ));
  }
}
