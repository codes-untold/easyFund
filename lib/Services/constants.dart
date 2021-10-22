
import 'package:first_ally/Widgets/onboardingwidget.dart';
import 'package:flutter/cupertino.dart';

class Constants{

  static List <Widget> item = [

    OnBoardingWidget(text1: "Make transfers from Anywhere",
      text2: "Make transfers at your convenience to and from"
          " any currency of your choice ",
        imgPath: "Images/onboarding_pic3.png",imgWidth: 300,),
    OnBoardingWidget(text1: "Easy Payment Methods", text2:
    "You have the benefit choosing your preferred payment method from "
        "a wide range of payment options",
        imgPath: "Images/onboarding_pic2.png",imgWidth: 270),
    OnBoardingWidget(text1: "Affordable service charges",
        text2: "We offer the best rates to provide you with smooth and easy "
            "transaction processes",
        imgPath: "Images/onboarding_pic5.png",imgWidth: 200),
  ];


  static const String PUBLIC_KEY = "FLWPUBK_TEST-7f782282dfb351547b3afdc7a71e7bbf-X";
  static const String ENCRYPTION_KEY =  "FLWSECK_TEST64bb089f5851";



}