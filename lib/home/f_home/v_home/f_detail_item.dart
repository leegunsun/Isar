import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swf/home/f_home/v_home/mo_detail_item.dart';

class DetailItem extends StatefulWidget {
  DetailItem({super.key, this.item, this.isShowImg});

  DetailItemModel? item;
  void Function()? isShowImg;

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  final double iconSize = 50;
  bool isImg = true;

  @override
  Widget build(BuildContext context) {

    final double getHeight = MediaQuery.of(context).size.height;
    double divHeight = getHeight / 2;

    return Material(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            LayoutBuilder(
              builder: (context, constraints) {
                if(isImg = false) {
                  divHeight = constraints.maxHeight;
                }
                return SliverPersistentHeader(delegate: _SliverPersistentHeader(
                  maxHight: divHeight,
                  minHight: 0,
                  child: Stack(
                    children: [
                      AnimatedSlide(
                        duration: Duration(seconds: 1),
                        offset: Offset(0,0),
                        child: Offstage(
                          offstage: isImg,
                          child: PageView.builder(
                                itemCount: 3, // item.mainImgUrl.lenght,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(color: Colors.accents[index],child: Text("kkkk"));
                                },
                              ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              widget.isShowImg;
                              isImg = !isImg;
                              setState(() {});
                            },
                            child: Container(
                              height: iconSize,
                              width: iconSize,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Icon(Icons.arrow_upward),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                    ),
                );
              }
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [

                ],
              ),
            )

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