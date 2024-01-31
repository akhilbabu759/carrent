import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool vehicalType = false;
  bool rLocationType = false;
  String pickupLocation = 'Chooce pickup location';
  String dropLocation = 'Chooce drop location';
  String pickupDate = '';
  String pickupTime = '';
  String dropDate = '';
  String droptime = '';
  String carname = '';
  bool fuel = false;
  String price = '';
  String status = '';
  void vechicalTypeChange(bool val) {
    vehicalType = val;
    update();
  }

  void fuelTypeChange(bool val) {
    fuel = val;
    update();
  }

  Future<void> vechicalNameChange(String val) async {
    carname = val;
    update();
  }

  Future<void> priceChange(String val) async {
    price = val;
    update();
  }

  Future<void> statusChange(String val) async {
    status = val;
    update();
  }

  void rlocationChange(bool val) {
    rLocationType = val;
    update();
  }

  void getPickuplocation(String val) {
    pickupLocation = val;
    update();
  }

  void getPickupdate(String val) {
    pickupDate = val;
    update();
  }

  void getPickupTime(String val) {
    pickupTime = val;
    update();
  }

  void getDropDate(String val) {
    dropDate = val;
    update();
  }

  void getDropTime(String val) {
    droptime = val;
    update();
  }

  void getDropLocation(String val) {
    dropLocation = val;
    update();
  }

  Future<void> storeData() async {
    log('hi 1');
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref(
        'https://carrent-b23d1-default-rtdb.asia-southeast1.firebasedatabase.app/');
    log('hi 2');
    String phnum =
        await FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    log(phnum.toString(), name: 'inner');
    String path = 'data/${phnum}';
    try {
      await dbRef.child(path).set({
        'profile': {
          'pic': 'hhj',
          'name': 'hhh',
          'email': 'ahhh',
          'phnum': phnum,
          'dob': '9999',
        },
        'booking': {
          'type': vehicalType,
          'r_location': rLocationType,
          'pick_loca': pickupLocation,
          'pick_date': '${pickupDate},${pickupTime}',
          'drop_date': '${dropDate},${droptime}',
          'car_name': carname,
          'fuel': fuel,
          'price': price,
          'status': status
        },
      });
    } on FirebaseException catch (e) {
      log('hi 3');
      log(e.toString());
      log('hi 4');
    } catch (e) {
      log(e.toString());
    }
    log('hi 5');
  }
}
