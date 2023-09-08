import 'package:firstapp/screens/description_screen.dart';
import 'package:firstapp/services/AuthServices.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/alert_box.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> dataList = [];

  @override
  Future<List<Map<String, dynamic>>> getData() async {
    return DmlLogic().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      backgroundColor: kSecondaryColor,
      onRefresh: ()async {
       await getData();
       setState(() {
         
       });
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
                onPressed: (){
                  alertDialog(context: context, yesCall: () async{
                   await AuthServices().handleLogout(context);

                  }, noCall: (){
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 20.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => description_screen(
                                      imagePath: dataList[index]['image'],
                                      text: dataList[index]["title"],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: screenHeight * 0.25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(dataList[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: kShadowColor,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 95.0, left: 26),
                                  child: Text(
                                    dataList[index]["title"],
                                    style: kHomeTitle,
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
