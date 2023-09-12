import 'package:firstapp/screens/HomeScreen.dart';
import 'package:firstapp/screens/bookmark_screen.dart';
import 'package:firstapp/screens/login_screen.dart';
import 'package:firstapp/screens/profile_screen.dart';
import 'package:firstapp/screens/signup_screen.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/AuthServices.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  void initState() {
    // TODO: implement initState
  }

  int selected = 0;
  final List<Widget> screenlist = <Widget>[
    const HomeScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  void onTap(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset:false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTap(0);
        },
        backgroundColor: selected == 0 ? kSecondaryColor : kIconColor,
        child:  Icon(
          Icons.home,
          color: kPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: SafeArea(
        child: screenlist.elementAt(selected),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kPrimaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                onTap(1);
              },
              child: Ink(
                height: screenHeight*0.07,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.bookmark,
                        color:
                        selected == 1 ? kSecondaryColor: kIconColor,
                      ),
                    ),
                    Text(
                      "Bookmarks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected == 1
                            ? kSecondaryColor: kIconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {

                onTap(2);
              },
              child: Ink(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color:
                      selected == 2 ?kSecondaryColor: kIconColor,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected == 2
                            ? kSecondaryColor
                            : kIconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}