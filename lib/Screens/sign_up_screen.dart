
import 'package:first_ally/Networking/authentication.dart';
import 'package:first_ally/Services/custom_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool loading = false;
  String username = "";
  String email = "";
  String password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool textCheck = false;
  bool wordCheck = false;



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
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Flexible(
                            child: Text("Create an Account!",
                              style: TextStyle(
                                  fontSize: 18.0
                              ),),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            validator: (value){

                              if(value!.length> 10){
                                return "Username max 10 letters";
                              }

                              if(value.isEmpty){
                                return "Username is Required";
                              }
                              return null;
                            },
                            onSaved: (value){
                              username = value!;
                            },
                            decoration: InputDecoration(
                                labelText: "Username",
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none
                                )
                            ),
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
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Password is Required";
                              }
                              if(value.length<6){
                                return "Password should be at least six characters";
                              }
                              return null;
                            },
                            onSaved: (value){
                              password = value!;
                            },
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
                            height: 10.0,
                          ),
                          RaisedButton(

                            onPressed: (){
                              createUser(username, email, password);

                            },
                            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            child: const Text("Sign Up",
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
                              Navigator.pop(context);
                            },
                            child: const Text("I've already an account",
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

        ));
  }


  createUser(String? username,email,password)async{
    if(!_formKey.currentState!.validate()){
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      loading = true;
    });
    await Authentication().createUser(username, email, password).then((value){
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



