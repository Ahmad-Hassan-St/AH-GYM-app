import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/toastMessages.dart';

class DmlLogic {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  void insertProductData({
    required String imageUrl,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    // Authentication
    // SharedPreferences

    // Data Store in Cloud Firestore

    if (_auth.currentUser != null) {
      DocumentReference productRef = _fireStore.collection('products').doc();
      await productRef.set({
        "image": imageUrl.toString(),
        "title": title.toString(),
        "description": description.toString(),
      });
      showSnackBar("Data Saved");
    } else {
      showSnackBar("User is not authenticated. Cannot upload image.");
    }
  }

  void updateProductData({
    required String docId,
    required String imageUrl,
    required String title,
    required String description,
  }) async {
    if (_auth.currentUser != null) {
      DocumentReference productRef =
          _fireStore.collection('products').doc(docId);
      await productRef.update({
        "image": imageUrl.toString(),
        "title": title.toString(),
        "description": description.toString(),
      });
      showSnackBar("Data Updated");
    } else {
      showSnackBar("User is not authenticated. Cannot update data.");
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('products').get();

    List<Map<String, dynamic>> dataList = [];

    querySnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> documentData =
          document.data() as Map<String, dynamic>;
      documentData['documentId'] =
          document.id; // Add the document ID to the map
      dataList.add(documentData);
    });

    return dataList;
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('products');

      await usersCollection.doc(documentId).delete();
      showSnackBar("Data Deleted Successfully");
    } on FirebaseAuthException catch (e) {
      showSnackBar("Error in Deleting ${e.code}");
    }
  }

  insertUserData(
      {required String phoneNumber,
      required String userName,
      required String email}) async {
    final serverTimestamp = FieldValue.serverTimestamp();
    CollectionReference usersCollection = _fireStore.collection('users');
    await usersCollection.add({
      "userName": userName,
      "phone": phoneNumber,
      "email": email,
      "timestamp": serverTimestamp,
    });
    showSnackBar("Successfully Registered");

  }

  Future<List<Map<String, dynamic>>> fetchDataByEmail(String email) async {
    CollectionReference usersCollection = _fireStore.collection('users');
    try {
      QuerySnapshot querySnapshot = await usersCollection
          .where("email", isEqualTo: email)
          .get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        dataList.add(data);
      });

      return dataList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
 Future<void> updateUserImageByEmail({required String email,required String imageUrl}) async {
    CollectionReference usersCollection = _fireStore.collection('users');

    try {
      QuerySnapshot querySnapshot = await usersCollection
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference userDocument = querySnapshot.docs.first.reference;

        await userDocument.update({"image": imageUrl});
      } else {
        print("User with email $email not found.");
      }
    } catch (e) {
      print("Error updating user image: $e");
    }
  }

}
