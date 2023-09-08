import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textwidget extends StatelessWidget {
  double? fontsize;
  FontWeight? fontWeight;
  Color? color;
  String? text;

  Textwidget(
      {this.color, this.fontWeight, this.fontsize, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: fontsize, fontWeight:fontWeight, color: color),
    );
  }
}
