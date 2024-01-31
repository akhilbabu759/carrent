import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/date_pick_page/presentation/date_picker.dart';
import 'package:gent/features/home/presentation/statemanaget/home_controller.dart';
import 'package:gent/features/location_pick/presentaion/location_pickup.dart';
import 'package:gent/features/vehical_select/presentation/vehical_select_page.dart';
import 'package:gent/utils/ui_components/alert_box_fl.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List tabTextChange = ['Car', 'Bike'];
  int tabIndex = 0;

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        vsync: this, length: 2); // Adjust length for the number of tabs
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomeController());
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(children: [
                SizedBox(
                  height: carAppStyle().bappSize(context).height * 0.05,
                ),
                TabBar(
                  dividerHeight: 0,
                  onTap: (value) {
                    log(value.toString());
                    if (value == 0) {
                      homeC.vechicalTypeChange(false);
                    } else {
                      homeC.vechicalTypeChange(true);
                    }
                    setState(() {
                      tabIndex = value;
                    });
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color.fromARGB(229, 90, 107, 26),
                  controller: tabController,
                  tabs: [
                    Tab(
                      icon: Image.network(
                          'https://i.pinimg.com/564x/44/62/ef/4462ef7c1dde3b10df95e20d2a9a2a02.jpg'),
                      // Icon(Icons.directions_car)
                    ),
                    Tab(
                        icon: Image.network(
                            'https://i.pinimg.com/736x/6e/8e/08/6e8e085d5c09c6d57d021bcced12cade.jpg')
                        //  Icon(Icons.electric_bike)
                        ),
                  ],
                  splashFactory: NoSplash.splashFactory,
                ),
                Gap(carAppStyle().bappSize(context).width * 0.04),
                Row(
                  children: [
                    CupertinoSwitch(
                      value: isSwitched,
                      onChanged: (value) {
                        homeC.rlocationChange(value);
                        log(value.toString());
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      // activeTrackColor: Colors.lightGreenAccent,
                      // activeColor: Colors.green,
                    ),
                    Gap(carAppStyle().bappSize(context).width * 0.04),
                    Text(
                        'Return ${tabTextChange[tabIndex]} to another location'),
                  ],
                ),
                Gap(carAppStyle().bappSize(context).height * 0.04),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return LocationPick(
                          isPickup: true,
                        );
                      },
                    ));
                  },
                  child: Container(
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
                      Icon(Icons.location_on_outlined),
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 14,
                      //   child: Image.network(
                      //       'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7911211/facebook-icon-md.png'),
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.022,
                      ),
                      Text(
                        homeC.pickupLocation,
                        style: TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 0.8,
                            // color: Color.fromARGB(180, 4, 72, 127),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ]),
                  ),
                ),
                Gap(MediaQuery.of(context).size.width * 0.035),
                isSwitched
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationPick(
                                isPickup: false,
                              );
                            },
                          ));
                        },
                        child: Container(
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
                            Icon(Icons.location_on_outlined),
                            // CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   radius: 14,
                            //   child: Image.network(
                            //       'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7911211/facebook-icon-md.png'),
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            Text(
                              homeC.dropLocation,
                              style: TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 0.8,
                                  // color: Color.fromARGB(180, 4, 72, 127),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )
                          ]),
                        ),
                      )
                    : SizedBox(),
                Gap(MediaQuery.of(context).size.width * 0.035),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DatePickerScreen(),
                    ));
                  },
                  child: Container(
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
                      Icon(Icons.calendar_month),
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 14,
                      //   child: Image.network(
                      //       'https://creazilla-store.fra1.digitaloceanspaces.com/icons/7911211/facebook-icon-md.png'),
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.022,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: Text(
                          homeC.pickupTime.isEmpty
                              ? 'Chooce Date & Time'
                              : 'P:${homeC.pickupTime},${homeC.pickupDate.substring(0, 10)},D:${homeC.droptime},${homeC.dropDate.substring(0, 10)}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 0.8,
                              // color: Color.fromARGB(180, 4, 72, 127),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ]),
                  ),
                ),
                Gap(carAppStyle().bappSize(context).height * 0.05),
                SizedBox(
                  height: 52,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              17.0), // Adjust the radius as needed
                        )),
                      ),
                      onPressed: () {
                        if (homeC.pickupLocation.isEmpty ||
                            homeC.pickupDate.isEmpty ||
                            homeC.pickupTime.isEmpty ||
                            homeC.dropDate.isEmpty ||
                            homeC.droptime.isEmpty) {
                          AlertBoxFlutt().showAlert(context, 'Please check!',
                              'Please ensure all field have data');
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return BikeListingScreen();
                            },
                          ));
                        }
                      },
                      child: Text(
                        'Proceed',
                        style:
                            TextStyle(color: Color.fromARGB(255, 213, 231, 18)),
                      )),
                ),
                Gap(20),
                SizedBox(
                  height: carAppStyle().bappSize(context).height * 0.14,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: carAppStyle().bappSize(context).height * 0.1,
                          width: carAppStyle().bappSize(context).width * 0.4,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 52, 70, 187),
                                Color.fromARGB(192, 175, 71, 71)
                              ]),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://i.pinimg.com/originals/dc/19/e9/dc19e9b94a372ebc21ffeb7623d5632a.png')),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    },
                  ),
                ),
                Gap(15),
                Container(
                  height: carAppStyle().bappSize(context).height * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 177, 227, 28),
                        Color.fromARGB(255, 155, 136, 11)
                      ]),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pinimg.com/originals/dc/19/e9/dc19e9b94a372ebc21ffeb7623d5632a.png')),
                      color: Color.fromARGB(255, 177, 227, 28),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Gap(15),
                Column(
                  children: [
                    ListTile(
                      title: Text('Frequently Asked Questions'),
                      // Style the text to match your design
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: ExpansionTile(
                        collapsedBackgroundColor:
                            Color.fromARGB(255, 216, 216, 214),
                        title: Text('How can I reserve Indus Go Car?'),
                        children: <Widget>[
                          ListTile(
                            title: Text(
                                'You can make a booking through our website www.indusgo.in or can book through our call center at .....'),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: ExpansionTile(
                        collapsedBackgroundColor:
                            Color.fromARGB(255, 216, 216, 214),
                        title: Text('Can I book for any period of time?'),
                        children: <Widget>[
                          ListTile(
                            title: Text('Answer to this question...'),
                          ),
                        ],
                      ),
                    )
                    // Add more ExpansionTiles for each question
                  ],
                ),
                Gap(30),
                Text('More FAQS')
              ]),
            ),
          );
        },
      ),
    );
  }
}
