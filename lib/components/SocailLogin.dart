import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SocialLogin extends StatelessWidget {
  final String imagePath;
  VoidCallback onTap;
   SocialLogin({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: kThirdColor),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(imagePath,height: 40,),
      ),
    );
  }
}
