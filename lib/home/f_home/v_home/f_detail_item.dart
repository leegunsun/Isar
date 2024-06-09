import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:swf/home/f_home/v_home/mo_detail_item.dart';
import 'package:swf/home/home_style/home_view_style.dart';

import '../home_controller.dart';

class DetailItem extends StatefulWidget {
  DetailItem({super.key, this.item, this.isShowImg});

  DetailItemModel? item;
  void Function()? isShowImg;

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.find();

  final double iconSize = 50;
  final double iconPaddingSize = 10;
  RxDouble currentPagePix = 0.0.obs;

  double get getHeadMinSize => iconSize + (iconPaddingSize * 2);

  RxBool isImg = true.obs;
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  RxDouble animatedValue = 0.0.obs;
  RxBool isShowBtn = true.obs;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );
  }

  void _scrollListener() {
    currentPagePix.value = _scrollController.position.pixels;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double getHeight = MediaQuery.of(context).size.height;
    double divHeight = getHeight / 2;
    animatedValue.value = divHeight;

    _animation = Tween<double>(begin: divHeight, end: getHeadMinSize)
        .animate(_curvedAnimation)
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
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> testMap = {"저자": "이건선", "출판사": "나무나무출판사", "평점": 5};

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              Obx(
                () => buildSliverPersistentHeader(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: HomeViewStyle.readTextPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top:  HomeViewStyle.readTextPadding * 2),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: testMap.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 5);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              String key = testMap.keys.elementAt(index);
                              dynamic value = testMap[key];
                              return buildRow(key, value);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: HomeViewStyle.readTextPadding * 2),
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[300]),
                          child: Center(
                              child: Text(
                            "가난다리만얼;ㅣㅏㄴㅁ얼;미낭러;니ㅏ럼니라가난다리만얼;ㅣㅏㄴㅁ얼;미낭러;니ㅏ럼니라가난다리만얼;ㅣㅏㄴㅁ얼;미낭러;니ㅏ럼니라가난다리만얼;ㅣㅏㄴㅁ얼;미낭러;니ㅏ럼니라가난다리만얼;ㅣㅏㄴㅁ얼;미낭러;니ㅏ럼니라",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                        ),
                      ),
                      Text("""
                      올해 초부터 캘리포니아 농부성 협력기관 한 곳으로부터 의뢰를 받아서 캘리포니아 한인 농부들에게 제공할 여러 가지 문서를 번역해 왔습니다. 작년에 우연한 계기로 서류를 번역해 드렸던 한인분이 적극 추천해 주셔서 본의 아니게 농업 분야 서류를 번역하게 되었네요. 덕분에 우수농산물관리제도(Good Agricultural Practices)라든가 식품안전계획(Food Safety Plan)과 같은 용어에 친숙해졌습니다. 우물 안 개구리처럼 사는 저에게는 새로운 세상이 신기하고 재밌습니다. :-)
                  
                  (나중에 타지역 한인 농부들도 참고하도록 웹에다 올릴 계획이고 정부 공개 자료를 이해하기 쉽도록 정리한 내용이니) 기밀을 유지하지 않아도 되는 문서라 한 문장 골라서 분석합니다. 신문 기사나 책처럼 정제되지 않은, 실생활에서 사용하는 문장이라 보시면 되겠습니다. 농장에서 사용하는 물은 1년에 한 번 수질 검사를 해야 하는데, 샘플 채취 방법을 설명하는 문장입니다.
                  
                  올해 초부터 캘리포니아 농부성 협력기관 한 곳으로부터 의뢰를 받아서 캘리포니아 한인 농부들에게 제공할 여러 가지 문서를 번역해 왔습니다. 작년에 우연한 계기로 서류를 번역해 드렸던 한인분이 적극 추천해 주셔서 본의 아니게 농업 분야 서류를 번역하게 되었네요. 덕분에 우수농산물관리제도(Good Agricultural Practices)라든가 식품안전계획(Food Safety Plan)과 같은 용어에 친숙해졌습니다. 우물 안 개구리처럼 사는 저에게는 새로운 세상이 신기하고 재밌습니다. :-)
                  
                  (나중에 타지역 한인 농부들도 참고하도록 웹에다 올릴 계획이고 정부 공개 자료를 이해하기 쉽도록 정리한 내용이니) 기밀을 유지하지 않아도 되는 문서라 한 문장 골라서 분석합니다. 신문 기사나 책처럼 정제되지 않은, 실생활에서 사용하는 문장이라 보시면 되겠습니다. 농장에서 사용하는 물은 1년에 한 번 수질 검사를 해야 하는데, 샘플 채취 방법을 설명하는 문장입니다.
                      """),
                    ],
                  ),
                ),
              ),
              // SliverFillRemaining(
              //   hasScrollBody: true,
              //   child: Container(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow(String key, dynamic value) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(key, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: value is int
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: List.generate(
                          value, (index) => const Icon(Icons.star)),
                    ))
                : Text(value, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      ],
    );
  }

  SliverPersistentHeader buildSliverPersistentHeader() {
    return SliverPersistentHeader(
      // pinned: true,
      delegate: _SliverPersistentHeader(
        maxHight: animatedValue.value,
        minHight: getHeadMinSize,
        child: Stack(
          children: [
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
              },
              child: animatedValue.value == getHeadMinSize
                  ? Center(child: Text("역행자", style: Theme.of(context).textTheme.headlineLarge,))
                  : PageView.builder(
                itemCount: 3, // item.mainImgUrl.lenght,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "https://i.namu.wiki/i/fiKhNkmJrnR-0ZEAxy8f2rAi183-DnOAXVF9SC16hzcLMPiK5wSehEyQ7Eww7lPVi48GhYmS7RtK2bkvgzh9ltkZkRofjhb-2dPcUPcylFLrbjJj6qAL52pX1UU_hhEpA5kJCnqR822JAbHrynNQFg.webp",
                    // color: Colors.accents[index],
                    // child: Center(child: Text("kkkk"))
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Offstage(
                offstage: (100 - currentPagePix.value).clamp(0, 1) == 0,
                child: AnimatedOpacity(
                  opacity: (100 - currentPagePix.value).clamp(0, 1),
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.all(iconPaddingSize),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isShowImg != null) {
                          widget.isShowImg!();
                        }
                        toggleFlag();
                      },
                      child: Container(
                        height: iconSize,
                        width: iconSize,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: isImg.value
                            ? const Icon(Icons.arrow_upward)
                            : const Icon(Icons.arrow_downward),
                      ),
                    ),
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
