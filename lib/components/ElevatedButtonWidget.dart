import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget({
    Key? key,
    required this.buttonText,
    this.foregroundColor,
    this.backgroundColor,
    required this.onPressed,
    this.height,
    this.width,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // Calculate the final width and height with default values if necessary
    final finalWidth = width ?? double.infinity;
    final finalHeight = height ?? 66;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        minimumSize: Size(finalWidth, finalHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "Roboto",
        ),
      ),
    );
  }
}
