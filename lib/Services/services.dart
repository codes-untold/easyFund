
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Services{

   displayToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

   String fixPrice(String price){
     switch (price.length) {
       case 4:
         return "${price.substring(0, 1)},${price.substring(1, 4)}";

       case 5:
         return "${price.substring(0, 2)},${price.substring(2, 5)}";


       case 6:
         return "${price.substring(0, 3)},${price.substring(3, 6)}";

       case 7:
         return "${price.substring(0,1)},${price.substring(1, 4)},${price.substring(4, 7)}";

       case 8:
         return "${price.substring(0,2)},${price.substring(2, 5)},${price.substring(5, 8)}";

       case 9:
         return "${price.substring(0,3)},${price.substring(3, 6)},${price.substring(6, 9)}";
     }
     return price;

   }

   Future <bool> firstTimerChecker()async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     bool boolValue = preferences.getBool("isFirstTimer")?? false;
     return boolValue;

   }

   Future <void> firstTimerSetter()async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setBool("isFirstTimer", true);
   }


   showInSnackBar(String text,BuildContext context){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
   }




}