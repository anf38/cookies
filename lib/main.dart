// ignore_for_file: deprecated_member_use

import 'package:cookies/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cookies/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ValueNotifier<bool> isDarkModeEnabled = ValueNotifier<bool>(false);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color.fromARGB(255, 112, 63, 63),
      ),
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color.fromARGB(255, 189, 118, 118),
      ),
    ),
  );

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
    setState(() {
      // no-op; rebuilding the widget will apply the updated theme
    });
  }

  @override
  Widget build(BuildContext context) {
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
