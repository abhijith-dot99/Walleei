import 'package:flutter/material.dart';
import 'package:waleei/utlis/helpers.dart';

class ImageGridItem extends StatelessWidget {
  final dynamic image;

  const ImageGridItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => downloadImage(image['src']['original'], context),
      child: Image.network(
        image['src']['medium'],
        fit: BoxFit.cover,
      ),
    );
  }
}
