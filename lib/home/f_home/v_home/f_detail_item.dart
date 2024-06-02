import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:swf/home/f_home/v_home/mo_detail_item.dart';

import '../home_controller.dart';

class DetailItem extends StatefulWidget {
  DetailItem({super.key, this.item, this.isShowImg});

  DetailItemModel? item;
  void Function()? isShowImg;

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();

  final double iconSize = 50;
  final double iconPaddingSize = 10;
  double get getHeadMinSize => iconSize + (iconPaddingSize * 2);

  RxBool isImg = true.obs;
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _animation;
  var animatedValue = 0.0.obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller
    );

    _animation = Tween<double>(begin: animatedValue.value, end: getHeadMinSize).animate(_curvedAnimation)
      ..addListener(() {
        animatedValue.value = _animation.value;
      });
  }

  void toggleFlag() {
    isImg.value = !isImg.value;
    animateValue();
  }

  void animateValue() {
    if (!(isImg.value)) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double getHeight = MediaQuery.of(context).size.height;
    double divHeight = getHeight / 2;
    animatedValue.value = divHeight;

    return Material(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            Obx(() =>
                SliverPersistentHeader(
                delegate: _SliverPersistentHeader(
                maxHight: animatedValue.value,
                minHight: 0,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Offstage(
                          offstage: !isImg.value,
                          child: PageView.builder(
                                itemCount: 3, // item.mainImgUrl.lenght,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(color: Colors.accents[index],child: Text("kkkk"));
                                },
                              ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.all(iconPaddingSize),
                            child: GestureDetector(
                              onTap: () {
                                widget.isShowImg;;
                                toggleFlag();
                                // setState(() {}) ;
                              },
                              child: Container(
                                height: iconSize,
                                width: iconSize,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: isImg.value ? const Icon(Icons.arrow_upward) : const Icon(Icons.arrow_downward) ,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverPersistentHeader extends SliverPersistentHeaderDelegate {

  final double maxHight;
  final double minHight;
  final Widget child;

  _SliverPersistentHeader({ required this.maxHight, required this.minHight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(child: child);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }}