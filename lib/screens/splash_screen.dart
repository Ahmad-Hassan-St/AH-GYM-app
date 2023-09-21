import 'package:firstapp/screens/HomeScreen.dart';
import 'package:firstapp/screens/admin_screen.dart';
import 'package:firstapp/screens/home_feed_screen.dart';
import 'package:firstapp/screens/login_screen.dart';
import 'package:firstapp/screens/onboard_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/notification_services.dart';
import '../utils/colors.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  NotificationServices notificationServices = NotificationServices();



  @override
  void initState() {
    notificationServices.requestNotificationPermission();

    // Cloud Messaging
    notificationServices.firebaseInit(context);

    // Device Token Refresh
    notificationServices.isTokenRefresh();
    // Device Token
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device Token');
      }
      if (kDebugMode) {
        print(value);
      }
    });

    super.initState();
    Timer(Duration(seconds: 2),(){
      checkIsLogin();

    });
  }
  void checkIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('email');
    print("Token Value");
    print(token);
    if (token == "admin@gmail.com" && token != null && token.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminScreen()));
    } else if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeFeedScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BoardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                width: 180,
                height: 200,
                color: kThirdColor,
                image: const AssetImage(
                  "assets/images/logo.png",
                ),
              ),
            ),
            Text(
              "GYM",
              style: TextStyle(
                color: kThirdColor,
                letterSpacing: 1.1,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
