import 'dart:convert';

import 'package:http/http.dart' as http;

class FirebaseAPIServices {
  sendPushNotifications(
      {required String title,
      required String body,
      required String token}) async {
    final String apiUrl = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'AAAAnAU1QEY:APA91bFmIHHtjaVKyb5j5uv2BOOsnrQaqFXD0TdqOhktQdgbyhvXKXdrhVBcKzRBwR6NM_nnL-IE7GWNNJzUSqo3i3p1rJXjShxmnJtsSs4COF5oUsuGQep-RoLl-tH8ga2pP4pnrvxP',
    };

    final Map<String, dynamic> data = {
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'title': title,
        'body': body
      },
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
        'android_channel_id': 'ahgyms'
      },
      'to': token
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // The request was successful, and you can parse the response data.
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle network and other errors here.
      print('Error: $e');
    }
  }
}
