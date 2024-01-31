import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20),
          TabBar(
            labelColor: Color.fromARGB(175, 73, 122, 4),
            indicatorColor: Color.fromARGB(175, 73, 122, 4),
            onTap: (value) {
              changeTab(value);
            },
            controller: tabController,
            tabs: [
              Tab(text: "Ongoing"),
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Center(child: Text("Home Tab")),
                Center(child: Text("Messages Tab")),
                Center(child: Text("Settings Tab")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
