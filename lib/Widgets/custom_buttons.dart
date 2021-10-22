import 'package:first_ally/Services/data_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButtons extends StatelessWidget {

  int index;

  CustomButtons({required this.index});
  late DataManager data;
  @override
  Widget build(BuildContext context) {
    data = Provider.of(context,listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 8,
        left: 8
      ),
      child: MaterialButton(
          onPressed: (){
            data.updateTransferAmount(index.toString());
          },
          color: Colors.grey[200],
          elevation: 2,
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(index.toString(),style:const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),),
          ),
      ),
    );
  }
}

class CustomExtras extends StatelessWidget {

  String function;
  IconData iconData;

  CustomExtras({required this.function,required this.iconData});
  late DataManager data;
  @override
  Widget build(BuildContext context) {
    data = Provider.of(context,listen: false);
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 8,
          left: 8
      ),
      child: MaterialButton(
        onPressed: (){
        data.buttonFunctions(function);
        },
        color: Colors.grey[200],
        elevation: 2,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(iconData,size: 15,)
        ),
      ),
    );
  }
}
