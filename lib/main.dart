import 'package:final_app/screen/conversion_screen.dart';
import 'package:final_app/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FormulasScreen.dart';
import 'firebase_options.dart';
import 'screen/login.dart';
import 'screen/sign_up.dart';
import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      '/home': (context) => HomeScreen(),
      '/convert': (context) => ConversionScreen(),
      '/history': (context) => HistoryScreen(),
      '/formulas': (context) => FormulasScreen(),
    },
  ));
}

