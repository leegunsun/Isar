import 'package:flutter/material.dart';

class CreateItem extends StatelessWidget {
  const CreateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining()
      ],
    );
  }
}
