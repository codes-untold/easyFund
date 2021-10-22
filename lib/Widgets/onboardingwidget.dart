import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {

  String imgPath;
  String text1;
  String text2;
  double? imgWidth;


  OnBoardingWidget({required this.text1,required this.text2,
    required this.imgPath,this.imgWidth});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Image.asset(imgPath,width: imgWidth,)),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(text1,

            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
            ),) ,

           const SizedBox(
              height: 20.0,
            ),
            Text(text2,
              softWrap: true,
              style: const TextStyle(
                  fontSize: 13.5,

              ),),],
        )
      ],
    );
  }
}
