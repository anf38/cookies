// ignore_for_file: deprecated_member_use

import 'package:cookies/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cookies/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

final _myBox = Hive.box('myBox');
ValueNotifier<bool> isDarkModeEnabled = ValueNotifier<bool>(_myBox.get("darkMode"));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    isDarkModeEnabled.addListener(_updateTheme);
  }

  @override
  void dispose() {
    isDarkModeEnabled.removeListener(_updateTheme);
    super.dispose();
  }

  void _updateTheme() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: const Color.fromARGB(255, 112, 63, 63),
          ),
    );

    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: const Color.fromARGB(255, 189, 118, 118),
          ),
    );

    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeEnabled,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cookie Clicker',
          theme: isDarkMode ? darkTheme : lightTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SignInScreen(),
        );
      },
    );
  }
}

//hive, local storage on the phone
//https://www.youtube.com/watch?v=FB9GpmL0Qe0
//2:05