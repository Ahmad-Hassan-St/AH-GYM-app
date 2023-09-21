import 'package:firstapp/screens/HomeScreen.dart';
import 'package:firstapp/screens/login_screen.dart';
import 'package:firstapp/screens/number_screen.dart';
import 'package:firstapp/screens/signup_screen.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/ElevatedButtonWidget.dart';
import '../components/elevatedloginButton.dart';
import '../components/startupWidget.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late PageController _controller = PageController();
  bool lastPage = false;
  int index = 0;

  late SharedPreferences _prefs;
  bool _showOnboarding = true; // Flag to show onboarding initially

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _showOnboarding = _prefs.getBool('showOnboarding') ?? true;

    // Update the shared preference to indicate that the onboarding has been shown
    if (_showOnboarding) {
      await _prefs.setBool('showOnboarding', false);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return _showOnboarding
        ? Scaffold(
            body: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      lastPage = (index == 2);
                    });
                  },
                  children: [
                    startupWidget(
                      imagePath: "assets/images/G1.jpg",
                      headingText: "SUPPLEMENTS",
                      paragraphText:
                          "I am going to do a workout daily to make me fit using this application",
                      buttomButton: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButtonWidget(
                            buttonText: 'Get Started',
                            backgroundColor: kPrimaryColor,
                            foregroundColor: kSecondaryColor,
                            width: 200,
                            height: 60,
                            onPressed: () {
                              if (index < 2) {
                                _controller.animateToPage(index + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    startupWidget(
                      imagePath: "assets/images/G4.jpg",
                      headingText: "SUPPLEMENTS",
                      paragraphText:
                          "I am going to do a workout daily to make me fit using this application",
                      buttomButton: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButtonWidget(
                            buttonText: 'Next ➤',
                            backgroundColor: kPrimaryColor,
                            foregroundColor: kSecondaryColor,
                            width: 200,
                            height: 60,
                            onPressed: () {
                              if (index < 2) {
                                _controller.animateToPage(index + 2,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    startupWidget(
                      imagePath: "assets/images/G3.jpg",
                      headingText: "SUPPLEMENTS",
                      paragraphText:
                          "I am going to do a workout daily to make me fit using this application",
                      buttomButton: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          elevatedbuttonLWidget(
                            onpressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            background_Color: Colors.deepPurpleAccent,
                            Elevation: 12,
                            fontcolor: Colors.white,
                            shadowcolor: Colors.black,
                            text: "Login",
                            kRegularPadding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          elevatedbuttonLWidget(
                            onpressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NumberScreen()));
                            },
                            background_Color: Colors.white,
                            Elevation: 12,
                            shadowcolor: Colors.black,
                            text: "Sign Up",
                            fontcolor: Colors.black,
                            kRegularPadding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: const Alignment(0, 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const LoginScreen();
  }
}
