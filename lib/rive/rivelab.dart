import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:swf/home/f_input/f_w_input/f_w_star.dart';
import 'package:swf/igtest.dart';
import 'package:swf/rive/artboardnestedinputs.dart';
import 'package:swf/rive/basic_text.dart';
import 'package:swf/rive/carousel.dart';
import 'package:swf/rive/custom_asset_loading.dart';
import 'package:swf/rive/custom_cached_asset_loading.dart';
import 'package:swf/rive/custom_controller.dart';
import 'package:swf/rive/event_open_url_button.dart';
import 'package:swf/rive/event_sounds.dart';
import 'package:swf/rive/event_star_rating.dart';
import 'package:swf/rive/example_state_machine.dart';
import 'package:swf/rive/liquid_download.dart';
import 'package:swf/rive/little_machine.dart';
import 'package:swf/rive/play_one_shot_animation.dart';
import 'package:swf/rive/play_pause_animation.dart';
import 'package:swf/rive/rive_audio.dart';
import 'package:swf/rive/rive_audio_out_of_band.dart';
import 'package:swf/rive/simple_animation.dart';
import 'package:swf/rive/simple_animation_network.dart';
import 'package:swf/rive/simple_machine_listener.dart';
import 'package:swf/rive/simple_state_machine.dart';
import 'package:swf/rive/skinning_demo.dart';
import 'package:swf/rive/state_machine_skills.dart';

class RiveLab extends StatefulWidget {
  RiveLab({super.key});

  @override
  State<RiveLab> createState() => _RiveLabState();
}

class _RiveLabState extends State<RiveLab> {
  final List<Widget> listWidget = [
    const ArtboardNestedInputs(),
    const StateMachineSkills(),
    const EventStarRating(),
    const SkinningDemo(),
    const SimpleStateMachine(),
    const StateMachineListener(),
    const SimpleNetworkAnimation(),
    const SimpleAssetAnimation(),
    const RiveAudioOutOfBandExample(),
    const RiveAudioExample(),
    const PlayPauseAnimation(),
    const PlayOneShotAnimation(),
    const LittleMachine(),
    const BasicText(),
    const AnimationCarousel(),
    const CustomAssetLoading(),
    const CustomCachedAssetLoading(),
    const SpeedyAnimation(),
    const EventOpenUrlButton(),
    const EventSounds(),
    const ExampleStateMachine(),
    const LiquidDownload(),
  ];

  void _onChanged (bool? value, int index) {

    int? getIndex;
    if (saveInt.contains(index)) {
      getIndex = saveInt.firstWhere((element) => element == index);
    } else {
      getIndex = null;
    }

    if(getIndex != null) {
      // saveInt.remove(index);
    } else {
      saveInt.add(index);
    }

    setState((){});
  }

  List<int> saveInt = [];

  var logger = Get.find<Logger>();

  bool isSavedInt (int index) => saveInt.any((element) => element == index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
          itemCount: listWidget.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (BuildContext context, int index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return Colors.lightGreenAccent;
                      }
                      return Colors.transparent;
                    }),
                    side: const BorderSide(
                        color: Colors.grey
                    ),
                    checkColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    value: isSavedInt(index),
                    onChanged: (value) {saveInt.remove(index); setState(() {

                    });}),
              ),
              Expanded(
                flex: 3,
                child: ElevatedButton(onPressed: (){
                  _onChanged(null, index);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return listWidget[index];
                  }));
                }, child: Text("Go to ${listWidget[index]}")),
              ),
            ],
          ),
        ));
  }
}
