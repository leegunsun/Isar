import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../home_style/home_view_style.dart';

class HomePageIMG extends StatefulWidget {
  HomePageIMG({super.key});

  @override
  _HomePageIMGState createState() => _HomePageIMGState();
}

class _HomePageIMGState extends State<HomePageIMG> with SingleTickerProviderStateMixin {
  final List<String> images = [
    'https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=9046601&filePath=L2Rpc2sxL25ld2RhdGEvMjAxNC8yMS9DTFM2L2FzYWRhbFBob3RvXzI0MTRfMjAxNDA0MTY=&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10004',
    'https://media.istockphoto.com/id/520700958/ko/%EC%82%AC%EC%A7%84/%EC%95%84%EB%A6%84%EB%8B%A4%EC%9A%B4-%EA%BD%83-%EB%B0%B0%EA%B2%BD%EA%B8%B0%EC%88%A0.jpg?s=612x612&w=0&k=20&c=gJx5-O9U1qXKZqKwv4KunrBae7RDNRcdse1nOdSk_0w=',
    'https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=13262118&filePath=L2Rpc2sxL25ld2RhdGEvMjAyMC8yMS9DTFMxMDAwNi82MmZhMWExMy03ZjRmLTQ1NWMtYTZlNy02ZTk2YjhjMjBkYTk=&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006',
  ];

  final double _boxSize = 200;
  double viewWidth = 0.0;
  final PageController _pageController = PageController();

  void _precacheImage(BuildContext context, String imageUrl) {
    final imageProvider = CachedNetworkImageProvider(imageUrl);
    precacheImage(imageProvider, context);
  }

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 10).animate(animationController);

    _pageController.addListener(() {
      if (_pageController.page != _pageController.page?.roundToDouble()) {
        animationController.value = 10.0;
      } else {
        animationController.reverse(from: 10);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewWidth = Get.width;
    for (var imageUrl in images) {
      _precacheImage(context, imageUrl);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HomeViewStyle.readTextPadding),
          child: Text("이 책은 어떤 내용일까요?", style: Theme.of(context).textTheme.titleLarge),
        ),
        Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onHorizontalDragDown: (_){

                if(animationController.value != 0) {
                  animationController.reverse();
                } else {
                  animationController.forward(from: 0).then((value) {
                    Future.delayed(const Duration(seconds: 1), () {
                      if(animationController.value != 0) {
                        animationController.reverse(from: 10);
                      }
                    });
                  });

                }
              },
              // onHorizontalDragCancel: (){
              //   animationController.reverse(from: 10);
              // },
              child: SizedBox(
                height: _boxSize,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: images[index],
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(viewWidth, animation.value),
                      painter: OvalPainterTop(),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(viewWidth, animation.value),
                      painter: OvalPainter(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint topPaint = Paint()
      ..color = Colors.white
      ..isAntiAlias = true // 안티앨리어싱 적용
      ..style = PaintingStyle.fill;

    // 타원의 상반부
    Path topPath = Path();
    topPath.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      0,
      -3.14,
    );
    canvas.drawPath(topPath, topPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OvalPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint topPaint = Paint()
      ..color = Colors.white
      ..isAntiAlias = true // 안티앨리어싱 적용
      ..style = PaintingStyle.fill;

    // 타원의 상반부
    Path topPath = Path();
    topPath.addArc(
      Rect.fromLTWH(0, -size.height, size.width, size.height * 2),
      0,
      3.14,
    );
    canvas.drawPath(topPath, topPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}