import 'package:currency_picker/currency_picker.dart';
import 'package:first_ally/Networking/exchange_rate.dart';
import 'package:first_ally/Services/data_manager.dart';
import 'package:first_ally/Services/services.dart';
import 'package:first_ally/Widgets/bottom_sheet_widget.dart';
import 'package:first_ally/Widgets/custom_button_widget.dart';
import 'package:first_ally/Widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';
import 'dart:convert';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataManager data;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xff9f5de2),
        title: const Text("EazyFund",style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.w900),),
        centerTitle: true,

      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    child: Center(
                        child: Consumer<DataManager>(
                          builder: (context,data,_){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(Services().fixPrice(data.transferAmount),style: const TextStyle(color: Colors.black54,
                                    fontSize: 50),),
                                Text(data.transferCurrency,style: TextStyle(),)
                              ],
                            );
                          },
                        ))),
                  Container(
                      width: double.infinity,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  const [
                                  Text("Transferring Currency:",style: TextStyle(fontStyle: FontStyle.italic),),
                                  SizedBox(height: 10,),
                                  Text("Receiving Currency:",style: TextStyle(fontStyle: FontStyle.italic),),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Consumer<DataManager>(
                                builder: (context,data,_){
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(data.transferCurrency,
                                            style: const TextStyle(fontWeight: FontWeight.w900),),
                                          const SizedBox(width: 5,),
                                          GestureDetector(
                                            child: const Text("edit",style: TextStyle(color: Color(0xff9f5de2),
                                                decoration: TextDecoration.underline),),
                                         onTap: (){
                                          selectCurrency(context, "send");

                                         }, )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text(data.receivingCurrency,
                                            style: const TextStyle(fontWeight: FontWeight.w900),),
                                          const SizedBox(width: 5,),
                                          GestureDetector(
                                            child: const Text("edit",style: TextStyle(color: Color(0xff9f5de2),
                                                decoration: TextDecoration.underline),),
                                        onTap: (){
                                              selectCurrency(context, "receive");
                                        },)
                                        ],
                                      )
                                    ],
                                  );
                                },

                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff9f5de2),width: 3
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))

                      )

                  ),
                  const SizedBox(height: 5,),

                  CustomButtonWidget(index: 1,),
                  CustomButtonWidget(index: 4,),
                  CustomButtonWidget(index: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomExtras(function: "clear", iconData: Icons.clear),
                      CustomButtons(index: 0),
                      CustomExtras(function: "undo", iconData: Icons.west_rounded)
                    ],
                  ),
                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<DataManager>(
                        builder: (context,data,_){
                          return GestureDetector(
                            onTap: (){

                               if(data.transferAmount == "0"){
                                 Services().showInSnackBar("Enter transfer Amount", context);
                               }
                               else{
                                 showModalBottomSheet(context: context, builder: (ctx){
                                   return BottomSheetPay();
                                 },shape: const RoundedRectangleBorder(
                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                 ));
                               }

                            },
                            child: Container(
                                width: 150,
                                height: 50,
                                child: const Center(
                                  child:  Text("SEND CASH",style: TextStyle(
                                      color: Color(0xff9f5de2),
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff9f5de2),
                                  ),
                                )

                            ),
                          );
                        },

                      ),
                      Consumer<DataManager>(
                        builder: (context,data,_){
                          return  Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(Services().fixPrice(data.receivingAmount.round().toString()),
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                              Text(data.receivingCurrency,style: TextStyle(fontSize: 12),),
                            ],
                          );
                        },

                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future <void> selectCurrency(BuildContext context,String function)async {
    data = Provider.of<DataManager>(context,listen: false);

    showCurrencyPicker(
      currencyFilter: ["USD","GBP","CAD","CVE","CDF","EGP","EUR","GMD","GHS","GNF","KES",
      "LRD","MWK","MAD","NZN","NGN","TZS","UGX","ZMK","ZMW", "BRL","ARS"],

      context: context,
      onSelect: (currency){

     setState(() {
       isLoading = true;
     });

     ExchangeRate().fetchData(currency.code).then((Response? response)async{

       final Map<String, dynamic> map = json.decode(response!.body)["conversion_rates"];
       data.updateCurrencySelectFunction(function,currency);
       data.convertCurrency(map,function);

       setState(() {
         isLoading = false;
       });
     }).onError((error, stackTrace){
       Services().displayToast("Network error occured");
       setState(() {
         isLoading = false;
       });
     });

      },
    );
  }

}
