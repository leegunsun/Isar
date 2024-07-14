import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HeartRiveIcon extends StatefulWidget {
  const HeartRiveIcon({super.key});

  @override
  State<HeartRiveIcon> createState() => _HeartRiveIconState();
}

class _HeartRiveIconState extends State<HeartRiveIcon> {

  late final StateMachineController _controller;
  SMIBool? _tab;
  SMIBool? _hover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _loadRiveFile (Artboard artboard) async {

    var _controller = StateMachineController.fromArtboard(artboard, "State Machine 1");

    if(_controller != null) {
      artboard.addController(_controller);
      _tab = _controller.getBoolInput("Pressed");
      _hover = _controller.getBoolInput("Hover");
      _controller.addEventListener(onRiveEvent);
    }
  }

  void onRiveEvent(RiveEvent event) {
    if(_tab == null) return;
    _tab!.value = !_tab!.value;
  }
  
  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/light_like.riv',
      fit: BoxFit.cover,
      onInit: _loadRiveFile,
    );
  }
}
