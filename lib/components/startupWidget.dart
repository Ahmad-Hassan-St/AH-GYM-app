import 'package:firstapp/components/container.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'elevatedloginButton.dart';

class startupWidget extends StatelessWidget {
  startupWidget({
    super.key,
    required this.imagePath,
    required this.headingText,
    required this.paragraphText,
    this.buttomButton,

  });

  final String imagePath;
  final String headingText;
  final String paragraphText;
  final Widget? buttomButton;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContainerWidget(
          image: imagePath,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    headingText,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kThirdColor),
                  ),
                ],
              ),
              Text(
                paragraphText,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    color: kThirdColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             buttomButton ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
