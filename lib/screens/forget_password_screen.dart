import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';
import '../utils/toastMessages.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool visibility = false;
  bool isPress = false;

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
              "Forget Password",
              style: kForgetPassword,
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
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
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
                  SizedBox(
                    height: screenHeight * 0.14,
                  ),
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
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  ButtonWidget(
                    backgroundColor: kSecondaryColor,
                    buttonTitle: isPress
                        ? buildCircularProgressIndicator(context)
                        : const Text("Reset Password"),
                    onPressed: () async {

                      String email = _emailController.text.trim().toString();

                      if (email.isNotEmpty) {


                        if (!isEmailValid(email)) {
                          setState(() {
                            isPress = false;
                          });
                          showSnackBar("Invalid Email Format");
                          return;
                        }

                        try {
                          setState(() {
                            isPress = true;
                          });
                          await _auth.sendPasswordResetEmail(email: email);
                          showSnackBar("Check Your Email ");
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          print("Message: $e");
                          setState(() {
                            isPress = false;
                          });

                          if (e is FirebaseAuthException &&
                              e.code == "user-not-found") {
                              showSnackBar("User not found, Please Register First");

                          } else {
                            showSnackBar("Error, Something Wrong");
                          }
                        }
                      }
                    },
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
