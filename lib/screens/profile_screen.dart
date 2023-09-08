import 'dart:io';
import 'dart:typed_data';

import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/list_tile.dart';
import '../services/image_processing_service.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';

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
  String userEmail="";

 Future fetchUserData() async{
   SharedPreferences sp = await SharedPreferences.getInstance();
    String? email = sp.getString('email');
    userEmail=email.toString();
    List<Map<String, dynamic>> fetchedData = await DmlLogic().fetchDataByEmail(email.toString());
    return fetchedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Center(
          child: Text(
            'User Profile',
            style: kDescriptionHeading.copyWith(color: kSecondaryColor)
          ),
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
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        image: AssetImage("assets/images/G5.jpg"),
                      ),
                    ),
                    Positioned(
                      top: 200,

                      left: (MediaQuery.of(context).size.width - 120) / 2,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: kPrimaryColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:  selectedImage != null
                              ? MemoryImage(selectedImage!.bytes,) as ImageProvider<Object>
                              :  NetworkImage(dataList[0]['image']),
                          child: const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
                  child: Column(
                    children: [
                      IconButton(onPressed: ()async{
                        XFile? file = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (file == null) return;
                        compressImage = await ImageProcessingService()
                            .compressImage(File(file.path));
                        Uint8List? imageData = ImageProcessingService()
                            .imageBytes(File(compressImage.path));
                        setState(() {
                          selectedImage = MemoryImage(imageData!);
                        });
                      }, icon: Icon(Icons.camera),),
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
                      ButtonWidget(
                        buttonTitle:  const Text(
                          "Update",
                        ),
                        onPressed: () async {
                          if(compressImage!=null){

                           final imageUrl = await ImageProcessingService().getUploadImageUrl(compressImage);
                           await DmlLogic().updateUserImageByEmail(email: userEmail, imageUrl: imageUrl);

                          }
                        },
                        backgroundColor: Colors.black,
                        borderRadius: 10,
                      )
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),

    );
  }
}

class ButtonWidget extends StatelessWidget {
  late Widget buttonTitle;
  late VoidCallback onPressed;
  Color? backgroundColor;
  late double? borderRadius;

  ButtonWidget({
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
