
import 'package:first_ally/Services/constants.dart';
import 'package:first_ally/Services/data_manager.dart';
import 'package:first_ally/Services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:provider/provider.dart';

class BottomSheetPay extends StatelessWidget {

  late DataManager data;
  @override
  Widget build(BuildContext context) {
    data = Provider.of<DataManager>(context,listen: false);

    return Container(
      height: 800,
      child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Transfer ",style: TextStyle(
                              fontSize: 17,
                          )),
                          Text(Services().fixPrice(data.receivingAmount.round().toString()),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            ),),

                          Text(" ${data.receivingCurrency}?",style: const TextStyle(
                            fontSize: 10
                          ),)
                        ],
                      ),
                      const  SizedBox(height: 20,),
                      const  Text("Hint: Test card details are available in my submission",
                      textAlign: TextAlign.center,)
                    ],

                  ),
                )),

            Column(
              children: [
                GestureDetector(
                  onTap: (){

                launchPayment(context,data.receivingAmount.round().toString(),data.receivingCurrency);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                            colors:  [Color(0xff7a08fa),Color(0xffad3bfc)]
                        )
                    ),
                    child: const Center(
                      child: Text("TRANSFER",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),

                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: const Center(
                      child:  Text("NO THANKS",style: TextStyle(
                          color: Color(0xff9f5de2),
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff9f5de2)
                      ),


                    ),
                  ),
                ),
              ],
            )
          ]),
      padding: EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40),
              topLeft: Radius.circular(40))
      ),
    );
  }


  void launchPayment(BuildContext context,String amount,String currency)async{


    final style = FlutterwaveStyle(
        appBarText: "EasyFund",
        buttonColor: const Color(0xff9f5de2),
        appBarIcon: const Icon(Icons.message, color: Colors.white),
        buttonTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        appBarColor: const Color(0xffd0ebff),
        dialogCancelTextStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 18,
        ),
        dialogContinueTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 18,
        )
    );
    final Customer customer = Customer(
        name: "roitech",
        phoneNumber: "08123058486",
        email: Provider.of<DataManager>(context).userEmail);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: Constants.PUBLIC_KEY,
        currency: currency,
        txRef: DateTime.now().toString(),
        amount: amount,
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        isTestMode: true);

    final response = await flutterwave.charge();

    if(response != null){
      {
        print(response.status);}
    }else{
      Services().displayToast("Unable to complete Transaction");
    }
  }
}