import 'dart:io';
import 'dart:typed_data';
import 'package:firstapp/components/button.dart';
import 'package:firstapp/components/textfield.dart';
import 'package:firstapp/screens/admin_view_screen.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/services/image_processing_service.dart';
import 'package:firstapp/utils/app_bar.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/image_container_widget.dart';
import '../utils/progress_indicator.dart';
import 'notifications_screen.dart';

class AdminScreen extends StatefulWidget {
  final String? dcoumentId;

  const AdminScreen({Key? key, this.dcoumentId}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String imageUrl = "";
  bool isLoading = false;
  bool isImage = false;
  var compressImage;
  MemoryImage? selectedImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(
        screenWidth: screenWidth * 0.03,
        appBarText: "Admin Panel",
      ),
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageContainerWidget(
                imageWidget: selectedImage != null
                    ? Image.memory(
                        selectedImage!.bytes,
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.25,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/G2.jpg",
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
                buttonTitle: const Text("Open Camera"),
                onPressed: () async {
                  XFile? file = await ImageProcessingService().imagePicker();
                  if (file == null) return;
                  compressImage = await ImageProcessingService()
                      .compressImage(File(file.path));

                  Uint8List? imageData = ImageProcessingService()
                      .imageBytes(File(compressImage.path));
                  setState(() {
                    selectedImage = MemoryImage(imageData!);
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                  buttonTitle: isLoading
                      ? buildCircularProgressIndicator(context)
                      : const Text("Save Data"),
                  backgroundColor: kSecondaryColor,
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      imageUrl = await ImageProcessingService()
                          .getUploadImageUrl(compressImage!);
                      DmlLogic().insertProductData(
                          imageUrl: imageUrl,
                          title: _titleController.text.toString(),
                          description: _descriptionController.text.toString(),
                          context: context);
                      setState(() {
                        isLoading = false;
                        _titleController.text = "";
                        _descriptionController.text = "";
                      });
                    } catch (e) {}
                  }),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  ButtonWidget(
                      buttonTitle: const Text("Admin View"),
                      width: screenWidth *0.4,
                      backgroundColor: kSecondaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AdminViewScreen()));
                      }),
                  ButtonWidget(
                      buttonTitle: const Text("Notifications"),
                      width: screenWidth *0.4,
                      backgroundColor: kSecondaryColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotificationScreen()));
                      }),


                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
