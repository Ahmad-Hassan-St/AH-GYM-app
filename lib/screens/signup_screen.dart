import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/login_screen.dart';
import 'package:firstapp/screens/number_screen.dart';
import 'package:firstapp/services/dml_logic.dart';
import 'package:firstapp/utils/colors.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';

import '../components/SocailLogin.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import '../services/AuthServices.dart';
import '../utils/progress_indicator.dart';
import '../utils/toastMessages.dart';

class SignUp extends StatefulWidget {
  final String phoneNumber; // Receive the phone number from NumberScreen

  SignUp({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  bool passwordsMatch = true;
  bool visibility = true;
  bool isPress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userName = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    String phoneNumber = widget.phoneNumber;

    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "SignUp",
              style: kNumberStyle,
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    enabled: true,
                    prefixIcon: Icons.phone,
                    hintText: "Phone",
                    labelText: "Verified Phone Number",
                    initialValue: phoneNumber,
                    readonly: true,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    prefixIcon: Icons.person,
                    hintText: "Enter your Name",
                    labelText: "User Name",
                    controller: _userName,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
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
                        return 'Password must contain at least 8 characters\none uppercase letter\none lowercase letter\none numeric digit\none special symbol';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    controller: _confirmPasswordController,
                    prefixIcon: Icons.lock,
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      child: Icon(
                        visibility ? Icons.visibility : Icons.visibility_off,
                        color:
                            visibility ? kSecondaryColor : Colors.grey.shade400,
                      ),
                    ),
                    obscure: visibility,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (value != _passwordController.text) {
                        passwordsMatch =
                            false; // Set to false if passwords don't match
                        return 'Passwords do not match';
                      } else {
                        passwordsMatch = true; // Set to true if passwords match
                        return null;
                      }
                    },
                    // Set the border color based on whether passwords match
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: passwordsMatch ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    onPressed: () async {
                      String email = _emailController.text.trim().toString();
                      String password =
                          _passwordController.text.trim().toString();

                      setState(() {
                        isPress = true;
                      });

                      try {
                        // Create a user with email and password using Firebase Authentication
                        UserCredential user =
                            await AuthServices().signUpWithAuth(
                          email: email,
                          password: password,
                        );

                        // Check if user creation was successful
                        if (user.user != null) {
                          await DmlLogic().insertUserData(
                              phoneNumber: phoneNumber,
                              userName: _userName.text.toString(),
                              email: email);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                      } catch (error) {
                        // Handle any registration errors here
                        print("Error during registration: $error");
                        showSnackBar("Registration failed. Please try again.");
                      }
                      setState(() {
                        isPress = false;
                      });
                    },
                    buttonTitle: isPress
                        ? buildCircularProgressIndicator(context)
                        : const Text("Register"),
                    backgroundColor: kSecondaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login?",
                          style: kLoginStyle,
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
                            User? user = userCredential.user;
                            if (user != null) {
                              showSnackBar("Successfully Registered");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
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
