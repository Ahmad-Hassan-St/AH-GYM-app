import 'package:flutter/material.dart';

CircularProgressIndicator buildCircularProgressIndicator(BuildContext context) {
  return
    CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.primary,
      ),
      backgroundColor:
      Theme.of(context).colorScheme.background,
    );
}