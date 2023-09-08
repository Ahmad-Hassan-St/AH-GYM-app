import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class ListTileWidget extends StatelessWidget {
  late String text;
  late IconData icon;
  late String leading;

  ListTileWidget(
      {super.key, Key,
        required this.text,
        required this.icon,
        required this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          text,
          style: kDescriptionHeading.copyWith(fontSize: 14),
        ),
        trailing: Text(
          leading,
          style: kToDoList.copyWith(fontSize: 12,),
        ),
      ),
    );
  }
}