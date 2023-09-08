import 'package:flutter/material.dart';

class elevatedbuttonLWidget extends StatelessWidget {
  VoidCallback? onpressed;
  Color? background_Color;
  late double? Elevation;
  Color? shadowcolor;
  late String? text = "";
  EdgeInsets? kRegularPadding =
      const EdgeInsets.symmetric(horizontal: 40, vertical: 15);
  FontWeight? fontweight;
  late double? fontsize;
  Color? fontcolor;

  elevatedbuttonLWidget({
    super.key,
    this.fontweight,
    this.fontcolor,
    this.fontsize,
    this.kRegularPadding,
    this.text,
    this.onpressed,
    this.background_Color,
    this.Elevation,
    this.shadowcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          backgroundColor: background_Color,
          elevation: Elevation,
          shadowColor: shadowcolor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(
        text?? '',
        style: TextStyle(
          fontWeight: fontweight,
          fontSize: fontsize,
          color: fontcolor,
        ),
      ),
    );
  }
}
