import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
  Widget build(BuildContext context) {
    for (var imageUrl in images) {
      _precacheImage(context, imageUrl);
    }
    return SizedBox(
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
    );
  }
}
