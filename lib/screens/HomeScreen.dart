import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstapp/screens/description_screen.dart';
import 'package:firstapp/services/AuthServices.dart';
import 'package:firstapp/services/db_helper.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/alert_box.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/toastMessages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> dataList = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isAddedToDatabase = false; // Initialize the state variable

  @override
  Future<List<Map<String, dynamic>>> getData() async {
    final data = await DmlLogic().fetchProductData();
    // print(data);
    return data;
  }

  dataInsert(
      {required String image,
      required String title,
      required String docId}) async {
    try {
      final result = await databaseHelper.insert({
        'docId': docId,
        'image': image,
        'title': title,
      });
      if (result != -1) {
        // Data was inserted successfully
        print('Data inserted with row ID: $result');
        showSnackBar("add to Bookmarks");
      } else {
        // Data insertion failed
        print('Failed to insert data');
        showSnackBar("Already to Bookmarked");
      }
    } catch (e) {
      showSnackBar("Already to Bookmarked");
    }
  }

  late final localData;

  getLocalData() async {
    await databaseHelper.init(); // Initialize the database helper

    final data = await databaseHelper.queryAllRows();

    setState(() {
      localData = data;
    });
    print(localData);
    return data;
  }

  @override
  void initState() {
    databaseHelper.init();
    getLocalData();
    super.initState();
  }

  List<bool> isBookmark = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      backgroundColor: kSecondaryColor,
      onRefresh: () async {
        await getData();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          actions: [
            Icon(Icons.notifications, color: kIconColor),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 17.0),
              child: IconButton(
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
                  color: kIconColor,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 24),
              child: Row(
                children: [
                  Text(
                    "Store",
                    style: kHomeStore,
                  ),
                ],
              ),
            ),
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
                          // isBookmark[index]=false;
                          // if (localData[index]['docId'] != null) {
                          //   setState(() {
                          //     isBookmark[index] = true;
                          //   });
                          //
                          // }

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 20.0,
                            ),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => description_screen(
                                      imagePath: dataList[index]['image'],
                                      text: dataList[index]["title"],
                                      animationIndex: "image$index",
                                    ),
                                  ),
                                );
                                // like code insert into  database
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
                                child: Hero(
                                  tag: 'image$index',
                                  // Use a unique tag for each image

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
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      await dataInsert(
                                                        image: dataList[index]
                                                            ['image'],
                                                        title: dataList[index]
                                                            ["title"],
                                                        docId: dataList[index]
                                                            ["documentId"],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      // Toggle the icon based on the state
                                                      Icons.bookmark,
                                                      size: 40,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 95.0,
                                                left: 26,
                                              ),
                                              child: Text(
                                                dataList[index]["title"],
                                                style: kHomeTitle,
                                              ),
                                            ),
                                          ],
                                        ),
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
