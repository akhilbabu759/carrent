import 'package:flutter/material.dart';

class AlertBoxFlutt {
  showAlert(BuildContext context, String tiltle, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tiltle,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(content),
          actions: <Widget>[
            // TextButton(
            //   child: Text('Cancel'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // You can perform some action here after pressing OK
                Navigator.of(context).pop(); // Dismiss the alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
