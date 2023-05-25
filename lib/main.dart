import 'package:cookies/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cookies/firebase_options.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cookie Clicker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const SignInScreen(),
    );
  }
}