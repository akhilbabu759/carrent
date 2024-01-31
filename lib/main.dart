import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gent/features/bottom_nav/presentation/bottom_nav.dart';
import 'package:gent/features/login/presentaion/login.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()
        // LoginPage(),
        );
  }
}
