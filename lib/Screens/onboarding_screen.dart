import 'package:first_ally/Screens/login_screen.dart';
import 'package:first_ally/Services/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingScreen extends StatefulWidget {


  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  int currentPos = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0,left: 15.0),
              child: GestureDetector(
                onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));
                },
                child: const Text("SKIP",
                  style:  TextStyle(
                      color: Color(0xff9f5de2),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500
                  ),),
              ),
            ),

            Expanded(
              flex: 12,
              child: CarouselSlider(
                items: Constants.item,
                options: CarouselOptions(
                    height: 500,
                    aspectRatio: 16/9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index,reason){
                      setState(() {
                        currentPos = index;
                        if(currentPos == 2){
                          isVisible = true;
                        }
                      });
                    }

                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children:[Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: Constants.item.map((e) {
                      int index = Constants.item.indexOf(e);
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPos == index?
                            const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                      );
                    }).toList(),
                  ),
                    Visibility(
                      visible: isVisible,
                      child: Positioned(
                          bottom: 0.1,
                          right: 8.0,
                          child: FlatButton(
                              onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return LoginScreen();
                                }));
                              },
                              child: const Text("DONE",
                                style:  TextStyle(
                                    color: Colors.white
                                ),),
                              color: Color(0xff9f5de2)
                          )
                      ),
                    ),]
              ),
            )
          ],
        ),
      ),
    );
  }
}
