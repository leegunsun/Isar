import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ItemList extends StatefulWidget {
  ItemList({super.key, required this.getItem, required this.onTap});

  final List<dynamic> getItem;
  final void Function() onTap;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final List<String> images = [
    'https://via.placeholder.com/400x300?text=Image+1',
    'https://via.placeholder.com/400x300?text=Image+2',
    'https://via.placeholder.com/400x300?text=Image+3',
  ];

  double maxHeight = 0.0;

  void test (BuildContext context,String imageUrl) {
    CachedNetworkImageProvider cache = CachedNetworkImageProvider(imageUrl);
    precacheImage(cache, context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                maxHeight = constraints.maxWidth;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: images[0],
                      // placeholder: (context, url) => Shimmer.fromColors(
                      //   baseColor: Colors.grey,
                      //   highlightColor: Colors.white,
                      //   child: Expanded(
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           color: Colors.grey[50],
                      //           borderRadius: BorderRadius.circular(12)),
                      //     ),
                      //   ),
                      // ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  ),
                );
              }
            ),
          ),
          Flexible(
            flex: 3,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight, // 최대 높이에 맞춰서 너비 제한
              ),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('24/01/11'),
                      Text("닌텐도 스위치 팝니다."),
                      Text("닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.닌텐도 스위치 팝니다.", overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),

            ),
          ),
        ],
      ),
    );
  }
}
