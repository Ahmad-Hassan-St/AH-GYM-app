// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  // AssetImage image= AssetImage("");
  late String image = "";
  Color? color;

ContainerWidget({
    super.key,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
         // colorFilter: ColorFilter.mode(kSecondaryColor.withOpacity(0.1)),
        ),
      ),
    );
  }
}
