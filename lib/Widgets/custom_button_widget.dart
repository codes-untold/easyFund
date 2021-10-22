import 'package:first_ally/Widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {

  int index;

  CustomButtonWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        CustomButtons(index: index),
        CustomButtons(index: index + 1),
        CustomButtons(index: index + 2),
      ],
    );
  }
}
