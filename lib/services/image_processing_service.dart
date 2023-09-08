import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageProcessingService{

  Future<XFile?> compressImage(File? file) async {
    if (file == null) return null;

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final compressedFile = File('$tempPath/${file.path.split('/').last}.jpg');

    final resultImage = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      compressedFile.path,
      quality: 50, // Adjust the quality value as needed (0-100)
    );

    return resultImage;
  }
  Future<XFile?> imagePicker() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return file;
  }

  Uint8List? imageBytes(File? pickedImageFile ) {
    if (pickedImageFile != null) {
      final bytes = pickedImageFile!.readAsBytesSync();
      return bytes.buffer.asUint8List();
    }
    return null;
  }

    Future<dynamic> getUploadImageUrl(XFile compressImage ) async{
        // UniqueFile Naming to avoid conflict
      String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceImageDirectory = referenceRoot.child('images');

      Reference imageToUpload = referenceImageDirectory.child(uniqueFileName);
      await imageToUpload.putFile(File(compressImage!.path));
     String imageUrl = await imageToUpload.getDownloadURL();
      return imageUrl;
    }


}