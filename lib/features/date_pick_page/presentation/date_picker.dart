import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gent/features/home/presentation/statemanaget/home_controller.dart';
import 'package:get/get.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  late DateTime selectedPickupDate;
  late DateTime selectedDropDate;
  late TimeOfDay selectedPickupTime;
  late TimeOfDay selectedDropTime;
  final homc = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    selectedPickupDate = DateTime.now();
    selectedDropDate = DateTime.now().add(Duration(days: 1));
    selectedPickupTime = TimeOfDay.now();
    selectedDropTime = TimeOfDay(
        hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? selectedPickupDate : selectedDropDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isPickup ? selectedPickupDate : selectedDropDate))
      setState(() {
        if (isPickup) {
          selectedPickupDate = picked;
          homc.getPickupdate(picked.toString());
        } else {
          selectedDropDate = picked;
          homc.getDropDate(picked.toString());
        }
      });
  }

  Future<void> _selectTime(BuildContext context, bool isPickup) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isPickup ? selectedPickupTime : selectedDropTime,
    );
    if (picked != null &&
        picked != (isPickup ? selectedPickupTime : selectedDropTime))
      setState(() {
        if (isPickup) {
          selectedPickupTime = picked;
          homc.getPickupTime('${picked.hour}:${picked.hour}');
        } else {
          selectedDropTime = picked;
          homc.getDropTime('${picked.hour}:${picked.hour}');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Pick-up Date & Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                title: Text('Pick-up Date'),
                subtitle: Text('${selectedPickupDate.toLocal()}'),
                trailing: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(175, 73, 122, 4),
                ),
                onTap: () {
                  _selectDate(context, true);
                },
              ),
            ),
            Gap(12),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                title: Text('Pick-up Time'),
                subtitle: Text(selectedPickupTime.format(context)),
                trailing: Icon(
                  Icons.access_time,
                  color: Color.fromARGB(175, 73, 122, 4),
                ),
                onTap: () {
                  _selectTime(context, true);
                },
              ),
            ),
            Gap(12),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                title: Text('Drop-off Date'),
                subtitle: Text('${selectedDropDate.toLocal()}'),
                trailing: Icon(Icons.calendar_today,
                    color: Color.fromARGB(175, 73, 122, 4)),
                onTap: () {
                  _selectDate(context, false);
                },
              ),
            ),
            Gap(12),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 231),
                  borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                title: Text('Drop-off Time'),
                subtitle: Text(selectedDropTime.format(context)),
                trailing: Icon(Icons.access_time,
                    color: Color.fromARGB(175, 73, 122, 4)),
                onTap: () {
                  _selectTime(context, false);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Handle next button press
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Next'),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 212, 210, 210),
            minimumSize: Size(double.infinity, 50), // full-width button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // rounded corners
            ),
          ),
        ),
      ),
    );
  }
}
