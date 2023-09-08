import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/services/AuthServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../components/button.dart';
import '../utils/colors.dart';
import '../utils/progress_indicator.dart';
import '../utils/text_style.dart';
import '../utils/toastMessages.dart';
import 'otp_screen.dart';

class NumberScreen extends StatefulWidget {


  const NumberScreen({Key? key,})
      : super(key: key);

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  late bool isLoading = false;
  String? verifyID = null;

  TextEditingController phoneController = TextEditingController();
  String countryDial = '+92';

  // verifyPhone(String phoneNumber) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: (PhoneAuthCredential credential) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         showSnackBar(e.message.toString());
  //       },
  //       codeSent: (String verificationId, int? forceResendingToken) {
  //         showSnackBar('OTP has sent to your phone number');
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (_) =>  OTPScreen(phoneNumber: phoneNumber,verifyID: verifyID,)));
  //
  //         setState(() {
  //           verifyID = verificationId;
  //           isLoading = false;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Number Verification",
              style: kNumberStyle,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: IntlPhoneField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialValue: '+92',
                onChanged: (country) {
                  setState(() {
                    countryDial = country.countryCode;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: ButtonWidget(
                buttonTitle: isLoading
                    ? buildCircularProgressIndicator(context)
                    : const Text("Send OTP"),
                onPressed: () async {
                  //verifyPhone(countryDial + phoneController.text.toString());
                  setState(() {
                    isLoading = true;
                  });

                  await AuthServices().verifyPhone(
                    phoneNumber: countryDial + phoneController.text.toString(),
                    context: context,

                  );

                  setState(() {
                    isLoading = false;
                  });
                },
                backgroundColor: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
