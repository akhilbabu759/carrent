import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/core/common_style/app_style.dart';
import 'package:gent/features/confirmation_page/presentaion/confirmation_page.dart';

class Bike {
  final String name;
  final String details;
  final int price;
  final String imagePath;

  Bike(this.name, this.details, this.price, this.imagePath);
}

class BikeListingScreen extends StatefulWidget {
  @override
  State<BikeListingScreen> createState() => _BikeListingScreenState();
}

class _BikeListingScreenState extends State<BikeListingScreen> {
  late TabController tabController;
  final List<Bike> bikes = [
    Bike('Honda Activa', '2 Seater, Without Gear, Petrol', 900,
        'https://i.pinimg.com/736x/a0/63/ff/a063ffa25535b4b63951a1ea900efc2f.jpg'),
    Bike('Honda Activa 6G', '2 Seater, Without Gear, Petrol', 1000,
        'https://i.pinimg.com/736x/a0/63/ff/a063ffa25535b4b63951a1ea900efc2f.jpg'),
    Bike('Royal Enfield Bullet 350 ES', '2 Seater, With Gear, Petrol', 1200,
        'https://i.pinimg.com/736x/a0/63/ff/a063ffa25535b4b63951a1ea900efc2f.jpg'),
    // Add more bikes as needed
  ];

  int _selectedKmIndex = 0;
  bool _withFuel = false;

  @override
  void initState() {
    super.initState();
    // tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IndusGo, Edapally, Cochin'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                final bike = bikes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ConfirmationScreen();
                      },
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Image.network(bike.imagePath),
                      title: Text(bike.name),
                      subtitle: Text(
                          '${bike.details}\n₹ ${bike.price} for 240 KMS without fuel'),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
          ),
          _buildKmAndFuelOptions(context),
        ],
      ),
    );
  }

  Widget _buildKmAndFuelOptions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Free Kms', style: Theme.of(context).textTheme.headline6),
          Gap(10),
          ToggleButtons(
            splashColor: Color.fromARGB(176, 69, 165, 165),
            selectedBorderColor: Color.fromARGB(176, 69, 165, 165),
            fillColor: Color.fromARGB(176, 69, 165, 165),
            selectedColor: Color.fromARGB(173, 13, 13, 13),
            color: Color.fromARGB(255, 57, 57, 57),
            borderRadius: BorderRadius.circular(20),
            isSelected: [
              _selectedKmIndex == 0,
              _selectedKmIndex == 1,
              _selectedKmIndex == 2,
            ],
            onPressed: (int index) {
              setState(() {
                _selectedKmIndex = index;
              });
            },
            children: <Widget>[
              SizedBox(
                  width: carAppStyle().bappSize(context).width * 0.2,
                  child: Center(child: Text('240 KMS'))),
              SizedBox(
                  width: carAppStyle().bappSize(context).width * 0.2,
                  child: Center(child: Text('480 KMS'))),
              SizedBox(
                  width: carAppStyle().bappSize(context).width * 0.2,
                  child: Center(child: Text('960 KMS'))),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFuelOptionButton(context, 'Without Fuel', !_withFuel),
              SizedBox(width: 10),
              _buildFuelOptionButton(context, 'With Fuel', _withFuel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFuelOptionButton(
      BuildContext context, String label, bool selected) {
    return ElevatedButton(
      child: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        primary: selected
            ? Color.fromARGB(177, 123, 222, 222)
            : const Color.fromARGB(255, 232, 229, 229),
      ),
      onPressed: () {
        setState(() {
          _withFuel = label == 'With Fuel';
        });
      },
    );
  }
}
