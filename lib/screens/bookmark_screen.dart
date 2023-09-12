import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstapp/services/db_helper.dart';
import 'package:firstapp/utils/toastMessages.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> getData() async {
    await databaseHelper.init(); // Initialize the database helper
    final data = await databaseHelper.queryAllRows();

    return data;
  }
deleteDat({required id})async{
 final result=await   databaseHelper.delete(id);
 if (result != -1) {
   // Data was inserted successfully
   print('Data Deleted with row ID: $result');
   showSnackBar("Remove Bookmark");

 } else {
   // Data insertion failed
   print('Failed to Delete data');
 }
}

  @override


  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      backgroundColor: kSecondaryColor,
      onRefresh: () async {
        await getData();
        setState(() {

        });
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Center(
              child: Text(
            "Bookmarks",
            style: kHomeStore,
          )),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                      return ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 20.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                deleteDat(id:dataList[index]['_id']);
                                setState(() {
                                });
                              },
                              child: Container(
                                height: screenHeight * 0.25,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.5,
                                      color: kShadowColor,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: dataList[index]['image'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: buildCircularProgressIndicator(
                                          context)),
                                  // You can customize the placeholder
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  // You can customize the error widget
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 95.0,
                                        left: 26,
                                      ),
                                      child: Text(
                                        dataList[index]["title"],
                                        style: kHomeTitle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
