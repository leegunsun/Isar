
import 'package:flutter/material.dart';

import '../../../main_style/main_style_color.dart';

class StarRatingWidget extends StatefulWidget {
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _rating = 0;

  void _onStarTapped(int index) {
    setState(() {
      _rating = index + 1;
    });
  }

  Widget _buildStar(int index) {
    IconData icon = index < _rating ? Icons.star : Icons.star_border;
    return GestureDetector(
      onTap: () => _onStarTapped(index),
      child: Icon(
        icon,
        color: index < _rating ? MainStyleColor.THEME_PRIMARY_SOFT_PINK : MainStyleColor.THEME_PRIMARY_SKY_BLUE,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
