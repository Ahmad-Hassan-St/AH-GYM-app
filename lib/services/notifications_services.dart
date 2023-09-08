import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../screens/notifications_screen.dart';

class NotificationServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token $fCMToken');

    // Background Message Handling
    // FirebaseMessaging.onBackgroundMessage(
    //     (message) => handleBackgroundMessage(message));
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title :${message.notification?.title}');
    print('Body :${message.notification?.body}');
    print('Payload :${message.data}');
  }

  void handleMessage(RemoteMessage message, BuildContext context) {
    if (message == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  // Future initPushNotifications() async {
  //   await _firebaseMessaging.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   _firebaseMessaging.getInitialMessage().then((value) => handleMessage(message, context));
  // }
}
