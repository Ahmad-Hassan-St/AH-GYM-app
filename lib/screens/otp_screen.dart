import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/components/button.dart';
import 'package:firstapp/screens/number_screen.dart';
import 'package:firstapp/screens/signup_screen.dart';
import 'package:firstapp/utils/progress_indicator.dart';
import 'package:firstapp/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../utils/colors.dart';
import '../utils/toastMessages.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verifyID;

  const OTPScreen({
    super.key,
    required this.verifyID,
    required this.phoneNumber,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late bool isLoading = false;
  String otpPin = " ";
  late Timer _timer;
  int _start = 60;
  bool timeOut = false;

  Future<void> verifyOTP() async {
    bool verificationSuccessful = false;

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: widget.verifyID,
          smsCode: otpPin,
        ),
      );

      verificationSuccessful = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        showSnackBar('Invalid OTP. Please enter a valid OTP.');
      }
    } finally {
      setState(() {
        isLoading = false;
      });

      if (verificationSuccessful) {
        showSnackBar("Number is Successfully Verify ");
        //Navigate the screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  SignUp(phoneNumber: widget.phoneNumber),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timeOut = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void dispose() {
    textEditingController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //startTimer();

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "OTP Screen",
            style: kNumberStyle,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              !timeOut
                  ? Text("Timer: $_start second",
                      textAlign: TextAlign.center, style: kDescriptionHeading)
                  : Text(
                      "Time Out",
                      textAlign: TextAlign.center,
                      style: kDescriptionHeading.copyWith(color: Colors.red),
                    ),
              SizedBox(
                height: screenHeight * 0.20,
              ),
              Text(
                "Phone: ${widget.phoneNumber} ",
                style: kNumberStyle,
              ),
              SizedBox(
                height: screenHeight * 0.045,
              ),
              Center(
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    selectedFillColor: Colors.grey,
                    selectedColor: Colors.blueGrey,
                    inactiveFillColor: kThirdColor,
                    inactiveColor: Colors.grey,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: kThirdColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: textEditingController,
                  onChanged: (value) {
                    setState(() {
                      otpPin = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor, // Background color
                  ),
                  onPressed: _start > 0 ? verifyOTP : null,
                  child: isLoading
                      ? buildCircularProgressIndicator(context)
                      : const Text("Verify"),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ButtonWidget(
                buttonTitle: const Text("Back"),
                backgroundColor: kSecondaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
