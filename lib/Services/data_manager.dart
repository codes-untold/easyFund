
import 'package:currency_picker/currency_picker.dart';
import 'package:first_ally/Services/services.dart';
import 'package:flutter/material.dart';

class DataManager extends ChangeNotifier{

  String userEmail = "";
  String transferAmount = "0";
  double receivingAmount = 0;
  double conversionFactor = 1;
  String transferCurrency = "NGN";
  String receivingCurrency = "NGN";
  bool isFieldClear = true;
  bool isConvertingByMultiplication = true;





  void setUserEmail(String email){
    userEmail = email;
    notifyListeners();
  }

  void updateTransferAmount(String value){

    if(isFieldClear && value == "0"){
      return;
    }
    if(isFieldClear){
      transferAmount = value;
      conversionFunction();
      isFieldClear = false;
    }
    else{

      if(transferAmount.length > 6){
        Services().displayToast("Transfer limit exceeded");
        return;
      }
      else{
        transferAmount = "$transferAmount$value";
        conversionFunction();
      }

    }
    notifyListeners();
  }


  void buttonFunctions(String function){

    switch(function){
      case "clear":
        transferAmount = "0";
        receivingAmount = 0;
        isFieldClear = true;
      break;
      case "undo":
        if(isFieldClear){

          return;
        }
        if(transferAmount.length == 1){
          transferAmount = "0";
          receivingAmount = 0;
          isFieldClear = true;
        }
        if(transferAmount.length > 1){
          transferAmount = transferAmount.substring(0,transferAmount.length - 1);
          conversionFunction();
        }
    }

    notifyListeners();
  }

  void updateCurrencySelectFunction(String function,Currency currency){

    switch(function){
      case "send":
        transferCurrency = currency.code;
        break;
      case "receive":
        receivingCurrency = currency.code;
        break;
    }
    notifyListeners();
  }

  void convertCurrency(Map <String,dynamic> map,String function){
    switch(function){
      case "send":
        isConvertingByMultiplication = true;
        if(map[receivingCurrency] is int){
          int value = map[receivingCurrency];
          conversionFactor = value.toDouble();
          receivingAmount = conversionFactor * int.parse(transferAmount);
          notifyListeners();
          return;
        }
        conversionFactor = (map[receivingCurrency]);
        receivingAmount = conversionFactor * int.parse(transferAmount);

        break;

      case "receive":
        isConvertingByMultiplication = false;
        if(map[transferCurrency] is int){
          int value = map[transferCurrency];
          conversionFactor = value.toDouble();
          receivingAmount = (int.parse(transferAmount)/conversionFactor).toDouble();

          notifyListeners();
          return;
        }

        conversionFactor = map[transferCurrency];
        receivingAmount = (int.parse(transferAmount)/conversionFactor).toDouble();

        break;
    }
    notifyListeners();
  }

  void conversionFunction(){
    if(isConvertingByMultiplication){
      receivingAmount = int.parse(transferAmount) * conversionFactor;
    }
    else{
      receivingAmount = int.parse(transferAmount) / conversionFactor;
    }
  }

}