import 'dart:io';
import 'dart:typed_data';

import 'package:firstapp/components/image_container_widget.dart';
import 'package:firstapp/screens/admin_edit_screen.dart';
import 'package:firstapp/screens/admin_screen.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/ContainerWidget.dart';
import '../services/AuthServices.dart';
import '../services/image_processing_service.dart';
import '../utils/alert_box.dart';
import '../utils/app_bar.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';

class AdminViewScreen extends StatefulWidget {
  const AdminViewScreen({Key? key}) : super(key: key);

  @override
  _AdminViewScreenState createState() => _AdminViewScreenState();
}

class _AdminViewScreenState extends State<AdminViewScreen> {
  Future<List<Map<String, dynamic>>> getData() async {
    return DmlLogic().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBar(
        screenWidth: screenWidth * 0.03,
        iconWidget: IconButton(
          onPressed: () {
            alertDialog(
              context: context,
              yesCall: () async {
                await AuthServices().handleLogout(context);
              },
              noCall: () {
                Navigator.pop(context);
              },
              heading: "Confirm Logout",
              description: "Do you really want to Logout?",
            );
          },
          icon: Icon(
            Icons.logout,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getData(),
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

              return GridView.builder(
                itemCount: dataList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  //mainAxisExtent: 20,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return ContainerWidget(
                    image_path: dataList[index]['image'],
                    productname: dataList[index]['title'],
                    iconDelete: const Icon(Icons.delete),
                    iconEdit: const Icon(Icons.edit),
                    onPressEdit: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditProductWidget(
                              docId: dataList[index]['documentId'],
                              initialDescription: dataList[index]
                                  ['description'],
                              initialTitle: dataList[index]['title'],
                              oldImage: dataList[index]['image'],
                            );
                          });
                    },
                    onPressDelete: () {
                      String documentId = dataList[index]['documentId'];
                      alertDialog(
                          yesCall: () async {
                            await DmlLogic().deleteDocument(documentId);
                            Navigator.pop(context);
                            setState(() {});
                          },
                          noCall: () {
                            Navigator.pop(context);
                          },
                          context: context);
                    },
                    onpressed: () async {
                      String documentId = dataList[index]['documentId'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminScreen(
                            dcoumentId: documentId.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
