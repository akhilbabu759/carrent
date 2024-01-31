import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/bottom_nav/presentation/bottom_nav.dart';
import 'package:gent/features/home/presentation/home.dart';
import 'package:gent/features/otp_screen/presentation/otp_screen.dart';
import 'package:gent/utils/ui_components/alert_box_fl.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phC = TextEditingController();
    FirebaseAuth _auth = FirebaseAuth.instance;

    void verifyPhoneNumber(String phoneNumber) async {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification completed.
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            // The provided phone number is not valid.
          }
          // Handle other errors.
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Otp_Screen(
              phoneId: verificationId,
            ),
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timed out. You may want to show a UI to let users enter the code manually.
        },
      );
    }

    // void signInWithOtp(String smsCode, String verificationId) async {
    //   // Create a PhoneAuthCredential with the code
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: smsCode,
    //   );

    //   // Sign in with the credential
    //   try {
    //     await _auth.signInWithCredential(credential);
    //     // Successful sign in
    //   } on FirebaseAuthException catch (e) {
    //     // Handle error
    //   }
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(97, 56, 183, 233),
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        Center(
                          child: Text(
                            'Go Ride with us',
                            style: GoogleFonts.akatab(
                                color: Color.fromARGB(133, 206, 0, 0),
                                fontSize: 27,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ),
                    Positioned(
                        bottom: 1,
                        left: 1,
                        child: SizedBox(
                            height:
                                carAppStyle().bappSize(context).height * 0.32,
                            width: carAppStyle().bappSize(context).width * 1,
                            child: Image.asset(
                              'assets/download.png',
                              fit: BoxFit.cover,
                            )))
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                      ),
                      Text('Or login using your favourite social account',
                          style: GoogleFonts.akatab(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )
                          // TextStyle(
                          //   wordSpacing: 0.1,
                          //   letterSpacing: 0.4,
                          // ),
                          ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromARGB(255, 227, 226, 226),
                                width: 0)),
                        child: Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.035,
                          ),
                          Image.network(
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.022,
                          ),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                                wordSpacing: 0.3,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromARGB(255, 227, 226, 226),
                                width: 0)),
                        child: Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.035,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Image.network(
                                'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7911211/facebook-icon-md.png'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.022,
                          ),
                          Text(
                            'Continue with Facebook',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 0.8,
                                color: Color.fromARGB(180, 4, 72, 127),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ]),
                      )
                    ]),
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 232, 232, 232),
                          spreadRadius: 0.3,
                          blurRadius: 3,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          offset: const Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 254, 254),
                          offset: const Offset(5, 0),
                        )

                        // BoxShadow(
                        //     color: Colors.white,
                        //     blurRadius: 1,
                        //     spreadRadius: 5,
                        //     offset: Offset(0, 2)),
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Enter your mobile number to continue',
                          style: GoogleFonts.akatab(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        controller: phC,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 12.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: 'Enter mobile number',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      SizedBox(
                        height: 52,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    17.0), // Adjust the radius as needed
                              )),
                            ),
                            onPressed: () {
                              if (phC.text.isNotEmpty &&
                                  phC.text.length == 10) {
                                verifyPhoneNumber(phC.text);

                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) {
                                //     return Otp_Screen(phoneId: phC.text);
                                //   },
                                // ));
                              } else {
                                AlertBoxFlutt().showAlert(
                                    context,
                                    'Something missing ..!',
                                    'Please enter 10 digit phone number');
                              }
                            },
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 213, 231, 18)),
                            )),
                      )
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
