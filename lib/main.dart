
import 'package:firebase_core/firebase_core.dart';
import 'package:first_ally/Screens/home_screen.dart';
import 'package:first_ally/Services/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Screens/splash_screen.dart';



Future <void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async{

  });

  await Firebase.initializeApp();
  runApp (ChangeNotifierProvider<DataManager>(
    create: (BuildContext context) => DataManager(),
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}


