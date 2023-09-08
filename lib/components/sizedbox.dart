
import 'package:flutter/material.dart';

class Sizeddbox extends StatelessWidget {
  const Sizeddbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight*0.03,
    );
  }
}