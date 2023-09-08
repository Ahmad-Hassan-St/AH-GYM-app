import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/number_screen.dart';
import 'package:firstapp/utils/toastMessages.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/admin_screen.dart';
import '../screens/home_feed_screen.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  //SigInWithGoogle
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await _auth.signInWithCredential(credentials);
  }

//SignIn Auth
  signInWithAuth(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (isEmailValid(email) && isPasswordValid(password)) {
      try {
        UserCredential userCredentials = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredentials.user;
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('email', email.toString());

        if (user?.email == "admin@gmail.com") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AdminScreen()));
        } else if (user != null) {
          print("User Email :${user.email}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeFeedScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e is FirebaseAuthException && e.code == "wrong-password") {
          showSnackBar("Wrong Password, Try Other");
        }
        if (e is FirebaseAuthException && e.code == "user-not-found") {
          showSnackBar("User not found, Please Register First");
        } else {
          showSnackBar("Error, Something Wrong");
        }
      }
    }
  }

//SignUp Auth
  signUpWithAuth(
      {required String email,
      required String password,
      }) async {
    if (isEmailValid(email) && isPasswordValid(password)) {
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (user != null) {
          showSnackBar("User Successfully Registered");
          return user;

        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          showSnackBar('Try another Email, It\'s already in use');
        } else {
          showSnackBar("Error : ${e.code}");
        }
      }
    }
  }


  verifyPhone({
    required String phoneNumber,
    required BuildContext context,

  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showSnackBar(e.message.toString());
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          showSnackBar('OTP has sent to your phone number');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(
                phoneNumber: phoneNumber,
                verifyID: verificationId,

              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  handleLogout(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('email');

    await _auth.signOut();
    showSnackBar("You are logout");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
