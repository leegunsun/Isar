import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swf/home/f_home/f_w_home/f_w_home_pageview.dart';
import 'package:swf/home/f_home/home_controller.dart';
import 'package:swf/home/f_home/homebinding.dart';
import 'package:swf/home/f_home/v_home/f_detail_item.dart';
import 'package:swf/home/home_style/home_font_style.dart';

import 'f_w_home/f_w_itemlist.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<String> testtest () async {
    return await Future.delayed(Duration(seconds: 2), () => "testond");
  }

  final double sliverListPadding = 10;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: testtest(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return CustomScrollView(
          cacheExtent: 300.0,
          slivers: [
            SliverPersistentHeader(
                delegate: _SliverPersistentHeader(
                    maxHight: 100,
                    minHight: 0,
                    child: Center(child: Text('독서 일기', style: HomeFontStyle.appBarStyle,))
                )),
            SliverToBoxAdapter(
              child: HomePageIMG(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: sliverListPadding, right: sliverListPadding,top: sliverListPadding, bottom: 0),
              sliver: SliverList.separated(
                 itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemList(
                      getItem: ['test'],
                      onTap: () {
                        Get.to(() =>  DetailItem(),
                            binding: HomeBinding());
                      },);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(thickness: 2,),
                    );
                  }),
            )
          ],
        );
      }
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