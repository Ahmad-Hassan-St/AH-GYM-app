import 'dart:io';
import 'dart:typed_data';

import 'package:firstapp/components/image_picker_choice.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:firstapp/utils/toastMessages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/list_tile.dart';
import '../services/image_processing_service.dart';
import '../utils/progress_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; // Store the selected image file

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  dynamic? compressImage;
  MemoryImage? selectedImage;
  String userEmail = "";

  Future fetchUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? email = sp.getString('email');
    userEmail = email.toString();
    List<Map<String, dynamic>> fetchedData =
        await DmlLogic().fetchDataByEmail(email.toString());
    return fetchedData;
  }

  imagePicker(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(
      source: source,
    );
    if (file == null) return;
    compressImage =
        await ImageProcessingService().compressImage(File(file.path));
    Uint8List? imageData =
        ImageProcessingService().imageBytes(File(compressImage.path));
    setState(() {
      selectedImage = MemoryImage(imageData!);
    });
  }

  bool isPress = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double coverHeight = MediaQuery.of(context).size.height / 4;
    double profileHeight = MediaQuery.of(context).size.height / 6;
    double top = coverHeight - profileHeight / 15;
    double bottom = profileHeight / 1.6;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text('User Profile',
              style: kDescriptionHeading.copyWith(color: kSecondaryColor)),
        ),
      ),
      body: FutureBuilder(
        // Replace 'future' with your asynchronous data fetching logic
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: buildCircularProgressIndicator(context),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;
            // Your Column widget with the data
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: bottom),
                        height: screenHeight *0.3,
                        child: Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          image: AssetImage("assets/images/G5.jpg"),
                        ),
                      ),
                      Positioned(
                        top: top,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: kPrimaryColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: selectedImage != null
                                ? MemoryImage(
                                    selectedImage!.bytes,
                                  ) as ImageProvider<Object>
                                : NetworkImage(dataList[0]['image']),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        left: screenWidth / 1.85,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LowerAlertBox(
                                      cameraPicker: () async {
                                        await imagePicker(ImageSource.camera);
                                        print("camera");
                                        Navigator.of(context).pop();
                                      },
                                      galleryPicker: () async {
                                        await imagePicker(ImageSource.gallery);
                                        Navigator.of(context).pop();

                                        print("gallery");
                                      },
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ListTileWidget(
                          text: 'Name',
                          icon: Icons.person,
                          leading: dataList[0]['userName'],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        ListTileWidget(
                          text: 'Email',
                          icon: Icons.email,
                          leading: dataList[0]['email'],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        ListTileWidget(
                          text: 'Phone number',
                          icon: Icons.phone,
                          leading: dataList[0]['phone'],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ButtonWidgetProfile(
                          buttonTitle: isPress
                              ? buildCircularProgressIndicator(context)
                              : Text(
                                  "Update",
                                ),
                          onPressed: () async {
                            try {
                              setState(() {
                                isPress = true;
                              });
                              if (compressImage != null) {
                                final imageUrl = await ImageProcessingService()
                                    .getUploadImageUrl(compressImage);
                                await DmlLogic().updateUserImageByEmail(
                                    email: userEmail, imageUrl: imageUrl);
                                showSnackBar("Data Updated successfully");
                                setState(() {
                                  isPress = false;
                                });
                              }
                            } catch (e) {}
                          },
                          backgroundColor: Colors.black,
                          borderRadius: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ButtonWidgetProfile extends StatelessWidget {
  late Widget buttonTitle;
  late VoidCallback onPressed;
  Color? backgroundColor;
  late double? borderRadius;

  ButtonWidgetProfile({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        onPressed: onPressed,
        child: buttonTitle,
      ),
    );
  }
}
//=======================
