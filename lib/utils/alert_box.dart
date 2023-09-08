import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

void alertDialog({
  required BuildContext context,
  required VoidCallback yesCall,
  required VoidCallback noCall,
  String? heading='Confirm Deletion',
  String? description='Do you really want to delete this?',
  String? leftButtonText="No",
  String? rightButtonText="Yes",
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(heading.toString()),
        content:  Text(description.toString()),
        actions: [
          TextButton(
            onPressed: noCall,
            child: Text(
              leftButtonText.toString(),
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
          TextButton(
            onPressed: yesCall,
            child: Text(
              rightButtonText.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}