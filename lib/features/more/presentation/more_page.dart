import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/login/presentaion/login.dart';

// class MorePage extends StatelessWidget {
//   const MorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0, // Removes the shadow under the app bar.
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: carAppStyle().bappSize(context).width * 0.18,
          ),
          Gap(10),
          Text('916282596263'),
          Expanded(
            child: ListView(
              children: ListTile.divideTiles(
                // This creates a divider between list tiles
                context: context,
                tiles: [
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('My Profile'),
                    onTap: () {
                      // Action when 'My Profile' is tapped
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.car_rental),
                    title: Text('Subscribe a Car'),
                    onTap: () {
                      // Action when 'Subscribe a Car' is tapped
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text('Customer Support'),
                    onTap: () {
                      // Action when 'Customer Support' is tapped
                    },
                  ),
                  // ... Add other ListTile widgets
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                          (route) => true);
                      // Action when 'Logout' is tapped
                    },
                  ),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
