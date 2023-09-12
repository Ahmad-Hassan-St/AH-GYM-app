import 'package:firstapp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LowerAlertBox extends StatelessWidget {
  late double alertDialogPosition;
  late VoidCallback? cameraPicker;
  late VoidCallback? galleryPicker;

  LowerAlertBox({
    this.alertDialogPosition = 70,
     required this.cameraPicker,
     required this.galleryPicker,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 80.0, right: 80, bottom: alertDialogPosition),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: cameraPicker,
                      icon:
                          Icon(Icons.camera, size: 30, color: kSecondaryColor),
                    ),
                    // Text(
                    //   "Camera",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.normal, fontSize: 12),
                    // )
                  ],
                ),
                Container(
                  height: 60,
                  color: Color(0xFFb7b7b7),
                  width: 2,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: galleryPicker,
                      icon: Icon(Icons.image, size: 30, color: kSecondaryColor),
                    ),
                    // Text(
                    //   "gallery",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.normal, fontSize: 12),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
