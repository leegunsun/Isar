import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:swf/home/f_home/f_w_home/f_w_home_pageview.dart';
import 'package:swf/home/f_home/home_controller.dart';
import 'package:swf/home/f_home/homebinding.dart';
import 'package:swf/home/f_home/v_home/f_detail_item.dart';
import 'package:swf/home/home_style/home_font_style.dart';
import 'package:swf/home/home_style/home_view_style.dart';

import 'f_w_home/f_w_itemlist.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  Future<String> testtest() async {
    return await Future.delayed(Duration(seconds: 2), () => "testond");
  }

  List<Widget> testCWidget = List.generate(8, (index) => GestureDetector(
    onTap: (){
      Get.to(() => DetailItem(), binding: HomeBinding());
    },
    child: Container(
      child: Center(child: Text("Test Container $index")),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
    ),
  ))..add(ElevatedButton(onPressed: (){}, child: Text("Test ElevatedButton")));


  final double sliverListPadding = HomeViewStyle.sliverListPadding;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: testtest(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return CustomScrollView(
            cacheExtent: 300.0,
            slivers: [
              ...topImgWidget(),
              ...horizontalWidget(context),
              ...listWidget(context),
            ],
          );
        });
  }

  List<Widget> topImgWidget () {
    return [
      SliverPersistentHeader(
          delegate: _SliverPersistentHeader(
              maxHight: 50,
              minHight: 0,
              child: const Center(
                  child: Text(
                    '',
                    style: HomeFontStyle.appBarStyle,
                  )))),
      SliverToBoxAdapter(
        child: HomePageIMG(),
      ),
    ];
  }

  List<Widget> horizontalWidget (BuildContext context) {
    return[
    _sliverPadding(
        sliver: SliverToBoxAdapter(
          child: Text("😄 나만의 도서관",style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    _sliverPadding(
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 130, // 리스트의 높이 설정
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              itemCount: testCWidget.length,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 3/2,
                  child: testCWidget[index],
                );
              },
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> listWidget (BuildContext context) {
    return [
    _sliverPadding(
        sliver: SliverToBoxAdapter(
          child: Text("✨ 최근 내역",style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    _sliverPadding(
        sliver: SliverList.separated(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ItemList(
                getItem: ['test'],
                onTap: () {
                  Get.to(() => DetailItem(), binding: HomeBinding());
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(
                  thickness: 2,
                ),
              );
            }),
      )
    ];
  }

  SliverPadding _sliverPadding ({required Widget sliver}) {
    return SliverPadding(
      padding: EdgeInsets.only(
          left: sliverListPadding,
          right: sliverListPadding,
          top: sliverListPadding,
          bottom: 0),
      sliver: sliver,
    );
  }
}

class _SliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double maxHight;
  final double minHight;
  final Widget child;

  _SliverPersistentHeader(
      {required this.maxHight, required this.minHight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
  }
}
