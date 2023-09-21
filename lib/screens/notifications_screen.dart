import 'package:firstapp/services/dml_logic.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/image_container_widget.dart';
import '../components/textfield.dart';
import '../services/send_notification.dart';
import '../utils/app_bar.dart';
import '../utils/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late List<String> tokens = [];

  getUsersToken() async {
    final List<String> data = await DmlLogic().fetchTokens();
tokens=data;
    print(data);
    return data;
  }

  @override
  void initState() {
    getUsersToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(
        screenWidth: screenWidth * 0.03,
        appBarText: "Notifications",
      ),
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageContainerWidget(
                imageWidget: Image.asset(
                  "assets/images/notification.jpg",
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //image widget
              TextFieldWidget(
                  controller: _titleController,
                  prefixIcon: Icons.title,
                  hintText: "Enter title",
                  labelText: "Title"),
              const SizedBox(
                height: 30,
              ),
              TextFieldWidget(
                  controller: _descriptionController,
                  prefixIcon: Icons.description,
                  hintText: "Enter Description",
                  labelText: "Description"),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                backgroundColor: kSecondaryColor,
                buttonTitle: const Text("Send Notifications"),
                onPressed: () async {                  print(tokens);

                await FirebaseAPIServices().sendPushNotifications(
                      title: _titleController.text.toString(),
                      body: _descriptionController.text.toString(),
                      token: tokens);

                },
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
