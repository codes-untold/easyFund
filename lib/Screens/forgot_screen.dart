
import 'package:first_ally/Networking/authentication.dart';
import 'package:first_ally/Screens/sign_up_screen.dart';
import 'package:first_ally/Services/custom_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';



class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool loading = false;
  String email = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: loading,
          child: Stack(
            children: [
              Container(
                child: CustomPaint(
                  size: Size(1000,(1000*2.5).toDouble()),
                  painter: RPSCustomPainter2(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height ,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key:  _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Forgot Password?",
                          style: TextStyle(
                              fontSize: 18.0
                          ),),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Email is required";
                            }

                            if(!Authentication().checkEmail(value)){
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (value){
                            email = value!;
                          },
                          decoration: InputDecoration(
                              labelText: "Email Address",
                              filled: true,
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              prefixIcon: Icon(Icons.mail_outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: (){
                            resetEmail(email);
                          },
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                          child: const Text("Reset Password",
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          color: Color(0xff9f5de2),

                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return SignUpScreen();
                            }));
                          },
                          child: const Text("I haven't an account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

  //handle operations when user clicks on reset button
  resetEmail(email)async{
    if(!_formKey.currentState!.validate()){
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      loading = true;
    });

    Authentication().resetEmail(email).then((value){
      setState(() {
        loading = false;
      });
    });
  }
}


