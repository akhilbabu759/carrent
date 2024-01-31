import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/features/bottom_nav/presentation/bottom_nav.dart';
import 'package:gent/features/home/presentation/home.dart';
import 'package:gent/utils/ui_components/alert_box_fl.dart';
import 'package:pinput/pinput.dart';

class Otp_Screen extends StatefulWidget {
  final String phoneId;
  const Otp_Screen({super.key, required this.phoneId});

  @override
  State<Otp_Screen> createState() => _Otp_ScreenState();
}

class _Otp_ScreenState extends State<Otp_Screen> {
  bool che = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController contro = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter OTP',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Gap(20),
          Center(
              child: Pinput(
            onCompleted: (value) {
              setState(() {
                che = true;
              });

              signInWithOtp(contro.text, widget.phoneId, context);
            },
            length: 6,
            controller: contro,
          )),
          che
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

FirebaseAuth _auth = FirebaseAuth.instance;

void signInWithOtp(
    String smsCode, String verificationId, BuildContext context) async {
  // Create a PhoneAuthCredential with the code
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );

  // Sign in with the credential
  try {
    await _auth.signInWithCredential(credential);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
        (route) => true);
    // Successful sign in
  } on FirebaseAuthException catch (e) {
    AlertBoxFlutt().showAlert(
        context, 'Something wrong..!', 'Please check otp is correct');
    // Handle error
  }
}
