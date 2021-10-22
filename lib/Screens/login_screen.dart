import 'package:first_ally/Networking/Authentication.dart';
import 'package:first_ally/Screens/sign_up_screen.dart';
import 'package:first_ally/Services/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'forgot_screen.dart';



class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  List <Map<String,dynamic>> list = [];
  bool _obscureText = true;
  String password = "";
  String email = "";
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  void toggle(){
    setState(() {
      if(_obscureText){
        _obscureText = false;
      }
      else{
        _obscureText = true;
      }
    });
  }


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
                child: Container(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Flexible(
                          child: Text("Welcome Back!",
                            style: TextStyle(
                                fontSize: 18.0
                            ),),
                        ),
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
                        TextFormField(
                          onChanged: (value){
                            password = value;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password is Required";
                            }
                            if(value.length<6){
                              return "Password should be at least six characters";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              labelText: "Password",
                              contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              fillColor: Colors.grey[300],
                              filled: true,
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: toggle,
                                icon: Icon(_obscureText == true? Icons.visibility_off:Icons.visibility),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ForgotScreen();
                              }));
                            },
                            child: const Text("Forgot Password?",
                              textAlign: TextAlign.right,),
                          ),

                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: (){
                            login(email, password);
                          },
                          padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                          child: const Text("Sign in",
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
                            Navigator.push(context, MaterialPageRoute(builder: (context){
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

  void login(email,password)async{
    if(!_formkey.currentState!.validate()){
      return;
    }

    _formkey.currentState!.save();
    setState(() {
      loading = true;
    });

    await Authentication().loginUser(email, password,context).then((value){
      setState(() {
        loading = false;

      });
    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
    });
  }
}
