import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../home_style/home_view_style.dart';

class HomePageIMG extends StatefulWidget {
  HomePageIMG({super.key});

  @override
  _HomePageIMGState createState() => _HomePageIMGState();
}

class _HomePageIMGState extends State<HomePageIMG> {
  final List<String> images = [
    'https://via.placeholder.com/400x300?text=Image+1',
    'https://via.placeholder.com/400x300?text=Image+2',
    'https://via.placeholder.com/400x300?text=Image+3',
  ];

  final double _boxSize = 200;

  void _precacheImage(BuildContext context, String imageUrl) {
    final imageProvider = CachedNetworkImageProvider(imageUrl);
    precacheImage(imageProvider, context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    for (var imageUrl in images) {
      _precacheImage(context, imageUrl);
    }
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
        SizedBox(
          height: _boxSize,
          child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
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
                  );
                },
              ),
        ),
      ],
    );
  }
}
