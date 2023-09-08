import 'dart:io';
import 'dart:typed_data';

import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/toastMessages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/image_container_widget.dart';
import '../components/textfield.dart';
import '../services/image_processing_service.dart';
import 'admin_screen.dart'; // You'll need to import the actual service

class EditProductWidget extends StatefulWidget {
  final String docId;
  final String oldImage;
  final String initialTitle;
  final String initialDescription;

  EditProductWidget({
    required this.docId,
    required this.oldImage,
    required this.initialTitle,
    required this.initialDescription,
  });

  @override
  _EditProductWidgetState createState() => _EditProductWidgetState();
}

class _EditProductWidgetState extends State<EditProductWidget> {
  MemoryImage? selectedImage;
  late String title;
  late String description;
  dynamic? compressImage;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    title = widget.initialTitle;
    description = widget.initialDescription;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: const Color(0xffE8EBF5),
      title: Text(
        'Edit Product',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageContainerWidget(
              imageWidget: selectedImage != null
                  ? Image.memory(
                      selectedImage!.bytes,
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.25,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      widget.oldImage,
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.25,
                      fit: BoxFit.cover,
                    ),
            ),
            SmallElevatedButton(
              onPressed: () async {
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
              },
              text: "Change Image",
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFormFieldWidget(
              prefixIcon: Icons.title,
              hintText: "Enter title",
              labelText: "Title",
              initialValue: widget.initialTitle,
              onChanged: (value) {
                setState(() {
                  title = value!;
                });
              },
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFormFieldWidget(
              prefixIcon: Icons.description,
              hintText: "Enter Description",
              labelText: "Description",
              initialValue: widget.initialDescription,
              onChanged: (value) {
                setState(() {
                  description = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        SmallElevatedButton(
          text: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SmallElevatedButton(
          text: "Save",
          onPressed: () async {
            if(compressImage==null){

              imageUrl=widget.oldImage;
            }
            else {
              imageUrl =
              await ImageProcessingService().getUploadImageUrl(compressImage);
            }

            DmlLogic().updateProductData(
                docId: widget.docId,
                imageUrl: imageUrl,
                title: title,
                description: description);
            setState(() {

            });
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SmallElevatedButton extends StatelessWidget {
  const SmallElevatedButton({required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      child: Text(
        text.toString(),
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
    );
  }
}
