import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/home/presentation/statemanaget/home_controller.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homC = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Honda Activa 6G',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '2 Seater, Without Gear, Petrol',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: carAppStyle().bappSize(context).height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 238, 238, 238)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:
                                carAppStyle().bappSize(context).height * 0.17,
                            width: double.infinity,
                            child: Image.network(
                              'https://i.pinimg.com/736x/a0/63/ff/a063ffa25535b4b63951a1ea900efc2f.jpg',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Gap(10),
                          Text('Includes 240 KMS without fuel'),
                          Gap(10),
                          Text('Extra Kms @ 3/km'),
                          Gap(10),
                          Text('Total duration :2 days'),
                        ],
                      ),
                    ),
                  ),
                  // ... more widgets for other details
                ],
              ),
              Gap(10),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 209, 207, 207)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Price Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    PriceDetailRow(title: 'Base Fare', amount: '5800'),
                    PriceDetailRow(title: 'Delivery Charge', amount: '1200'),
                    PriceDetailRow(title: 'Tax', amount: '1900'),
                    Divider(),
                    PriceDetailRow(
                        title: 'Total Price', amount: '8,900', isTotal: true),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.add, size: 20),
                        Text(' Refundable Deposit')
                      ],
                    )
                  ],
                ),
              ),

              // ... Container for location and date details
              // ... More UI elements
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: ElevatedButton(
                  child: Text('Proceed to book'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Background color
                    onPrimary: Colors.white, // Text Color (Foreground color)
                  ),
                  onPressed: () async {
                    log(FirebaseAuth.instance.currentUser!.phoneNumber
                        .toString());
                    await homC.vechicalNameChange('hond activa');
                    await homC.priceChange('8900');
                    await homC.statusChange('booked');
                    homC.storeData();
                    // Handle payment action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceDetailRow extends StatelessWidget {
  final String title;
  final String amount;
  final bool isTotal;

  const PriceDetailRow({
    Key? key,
    required this.title,
    required this.amount,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
