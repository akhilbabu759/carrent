import 'package:flutter/material.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/home/presentation/statemanaget/home_controller.dart';
import 'package:get/get.dart';

class LocationPick extends StatelessWidget {
  const LocationPick({super.key, required this.isPickup});
  final bool isPickup;

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomeController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(carAppStyle().bappSize(context).width,
            carAppStyle().bappSize(context).height * 0.1),
        child: AppBar(
          // backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: const Center(child: Icon(Icons.arrow_back_ios)),
              ),
            ),
          ),
          title: const Text(
            'Choose Pick-up City',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Cochin'),
                  leading: Icon(Icons.location_city, color: Colors.green),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Our locations in Cochin',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Perform some action when this button is pressed.
              },
              icon: Icon(Icons.store_mall_directory, color: Colors.white),
              label: Text('IndusGo, Edapally'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize:
                    Size(double.infinity, 50), // double.infinity is the width
              ),
            ),
            Spacer(), // Use a Spacer widget to push the button to the bottom of the screen
            ElevatedButton(
              onPressed: () {
                if (isPickup) {
                  homeC.getPickuplocation('IndusGo, Edapally,kochin');
                } else {
                  homeC.getDropLocation('IndusGo, Edapally,kochin');
                }

                Navigator.pop(context);
                // Navigate to next page or perform an action when the button is pressed.
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Next'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 215, 213, 213),
                minimumSize:
                    Size(double.infinity, 50), // double.infinity is the width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: carAppStyle().bappSize(context).height * 0.02),
          ],
        ),
      ),
    );
  }
}
