import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: Column(
        children: [
            Image.asset("Iamges/alert_logo.png"),
            SizedBox(height: 10,),
            Text("Transaction Successful")
        ],
      ),
    );
  }
}
