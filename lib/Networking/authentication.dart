
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_ally/Screens/home_screen.dart';
import 'package:first_ally/Services/data_manager.dart';
import 'package:first_ally/Services/services.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


class Authentication{
  final _auth = FirebaseAuth.instance;
  Services services = Services();




//create user account on firebase
Future <void> createUser(username,email,password)async{
  try {
    UserCredential newUser = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    await newUser.user!.updateDisplayName(username).then((value)async{
      await newUser.user!.sendEmailVerification().then((value){
        services.displayToast("Please check your email for verification");
      });

    });
  } on Exception catch (e) {

    if(e.toString().contains("EMAIL_ALREADY_IN_USE")){
      services.displayToast("Email aleady exists");
    }

    if(e.toString().contains("NETWORK_REQUEST_FAILED")){
      services.displayToast("Network problem occured");
    }
  }
}


  //check for wrong email formatting
  bool checkEmail(String value){
    if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
      return false;
    }
    else{
      return true;
    }
      }

  //login user into app
      Future <void> loginUser(String email,password,context)async{

        try {
          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);

          if (newUser.user!.emailVerified) {
            await Services().firstTimerSetter().then((value){
              Provider.of<DataManager>(context).setUserEmail(email);
              Navigator.pushReplacement(context,PageTransition(type: PageTransitionType.rightToLeft,child: HomeScreen()));
            }).onError((error, stackTrace) {
              services.displayToast("Unable to login");
            });


          }
          else {
            services.displayToast("Email not verified");
          }
        } on Exception catch (e) {
          print(e.toString());
          if(e.toString().contains("network")){
            services.displayToast("Network problem occured");
          }

          if(e.toString().contains("password")){
            services.displayToast("Incorrect password");

          }
          if(e.toString().contains("user")){
            services.displayToast("User not found");
          }
        }
      }

      //Sends user email for password reset
      Future <void> resetEmail(email)async{
        try {
          await  _auth.sendPasswordResetEmail(email: email);
          services.displayToast(" Reset link has been sent to your email");

        } on Exception catch (e) {
          if(e.toString().contains("no user record")){
            services.displayToast("User not found");
          }
        }
      }
}