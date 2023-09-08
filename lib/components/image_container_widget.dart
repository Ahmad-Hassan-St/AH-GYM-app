import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ImageContainerWidget extends StatelessWidget {
  const ImageContainerWidget({
  super.key,
  required this.imageWidget,
  });

  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: kGradient,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            spreadRadius: 4,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageWidget,
      ),
    );
  }
}