import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/components/sizedbox.dart';
import 'package:firstapp/screens/home_feed_screen.dart';
import 'package:firstapp/screens/admin_screen.dart';
import 'package:firstapp/screens/forget_password_screen.dart';
import 'package:firstapp/screens/HomeScreen.dart';
import 'package:firstapp/screens/number_screen.dart';
import 'package:firstapp/screens/signup_screen.dart';
import 'package:firstapp/screens/splash_screen.dart';
import 'package:firstapp/services/AuthServices.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/SocailLogin.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import '../services/notification_services.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';
import '../utils/toastMessages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility = true;
  bool isPress = false;
  String imageUrl = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Welcome to Login",
              style: TextStyle(
                color: kSecondaryColor,
                letterSpacing: 0.5,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 29),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: screenHeight * 0.31,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(40)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/G1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Sizeddbox(),
                  TextFormFieldWidget(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: "Email",
                    labelText: "Email",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!isEmailValid(value)) {
                        return 'Invalid Email Format';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  Sizeddbox(),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText: "Enter your Password",
                    labelText: "Password",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          if (visibility) {
                            visibility = false;
                          } else {
                            visibility = true;
                          }
                        });
                      },
                      child: Icon(
                          visibility ? Icons.visibility : Icons.visibility_off,
                          color: visibility
                              ? kSecondaryColor
                              : Colors.grey.shade400),
                    ),
                    obscure: visibility,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (!isPasswordValid(value)) {
                        return 'Password must contain at least 8 characters\nnone uppercase letter\none lowercase letter\none numeric digit\none special symbol';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen()));
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(color: kSecondaryColor),
                        ),
                      ),
                    ],
                  ),
                  ButtonWidget(
                      backgroundColor: kSecondaryColor,
                      buttonTitle: isPress
                          ? buildCircularProgressIndicator(context)
                          : const Text("Login"),
                      onPressed: () async {
                        setState(() {
                          isPress = true;
                        });
                        //notification handling adding token in users collection and tokens
                        NotificationServices notificationServices =
                            NotificationServices();
                        notificationServices.getDeviceToken().then((value) {
                          if (kDebugMode) {
                            print('Device Token');
                          }
                          if (kDebugMode) {
                            print(value);
                            DmlLogic().updateUserFcTokenByEmail(
                                email: _emailController.text.trim().toString(),
                                fcToken: value
                            );
                            DmlLogic().insertTokenData(token: value);
                          }
                        });
                        await AuthServices().signInWithAuth(
                            email: _emailController.text.trim().toString(),
                            password:
                                _passwordController.text.trim().toString(),
                            context: context);

                        setState(() {
                          isPress = false;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: kAccountStyle,
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NumberScreen(),
                          ),
                        ),
                        child: Text(
                          "SignUp?",
                          style: kSignUp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLogin(
                          imagePath: "assets/images/google.png",
                          onTap: () async {
                            UserCredential userCredential =
                                await AuthServices().signInWithGoogle();
                            User? user = userCredential
                                .user; // Extract the User object from UserCredential
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeFeedScreen()),
                              );
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
