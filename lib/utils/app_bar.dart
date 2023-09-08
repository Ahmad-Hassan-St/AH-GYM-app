import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

AppBar buildAppBar(
    {required double screenWidth, String appBarText = "Admin View", double leftPadding = 70, Widget? iconWidget,}) {
  return AppBar(
    elevation: 0,
    foregroundColor: kThirdColor,
    backgroundColor: kSecondaryColor,
    title: Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Text(
        appBarText,
        style: kAppBarTextStyle,
      ),
    ),
    actions: [

      Padding(
          padding: const EdgeInsets.only(right: 17.0),
          child:iconWidget,
      ),
    ],
  );
}