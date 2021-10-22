

import 'package:first_ally/Screens/login_screen.dart';
import 'package:first_ally/Screens/onboarding_screen.dart';
import 'package:first_ally/Services/services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Services().firstTimerChecker().then((bool value){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return value?LoginScreen():OnboardingScreen();
        }));
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: Image.asset("Images/logo.png",width: 200,height: 200,)),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors:  [Color(0xff7a08fa),Color(0xffad3bfc)]
            )
        ),
      ),
    );
  }
}
