import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

class description_screen extends StatefulWidget {
  final String imagePath;
  final String text;

  const description_screen({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  State<description_screen> createState() => _description_screenState();
}

class _description_screenState extends State<description_screen> {
  List<String> tasks = [
    "Do 10 push-Ups on a daily basis.",
    "Do 10 planks for 6 days.",
    "Go for running at 6 am in the morning for 7 days",
    "Lunges: 3 sets of 10 reps per leg",
    "Jumping Jacks: 3 sets of 20 reps",
    "Bicycle Crunches: 3 sets of 15 reps per side",
    "Go for running at 6 am in the morning for 7 days",
  ];
  late List<bool> taskStatus;



  @override
  void initState() {
    super.initState();
    taskStatus = List<bool>.filled(tasks.length, false);
  }

  void resetCheckboxes() {
    setState(() {
      taskStatus = List<bool>.filled(tasks.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
               height: screenHeight * 0.306,
               width: double.infinity,
               child: Image(
                image: NetworkImage(widget.imagePath),
            ),
             ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30),
              child: Text(
               widget.text,
                style: kDescriptionHeading
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: screenHeight * 0.50,
                decoration: BoxDecoration(
                  color: kThirdColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.grey,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 20,
                    right: 28,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "Tasks List",
                            style: kDescriptionSubHeading,
                          ),
                          GestureDetector(
                            onTap: resetCheckboxes,
                            child: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.012,
                      ),
                      Expanded(
                        child: Scrollbar(
                          thickness: 9,
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: taskStatus[index],
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        taskStatus[index] = newValue ?? false;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      tasks[index],
                                      style: kToDoList,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
