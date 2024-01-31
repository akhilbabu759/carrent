import 'package:flutter/material.dart';
import 'package:gent/features/booking/presentation/booking.dart';
import 'package:gent/features/home/presentation/home.dart';
import 'package:gent/features/more/presentation/more_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    homePage(),
    BookingPage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation Demo'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Acconunt',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(175, 73, 122, 4),
        onTap: _onItemTapped,
      ),
    );
  }
}
