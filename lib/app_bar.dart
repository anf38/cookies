import 'package:cookies/screens/CookiePage.dart';
import 'package:cookies/screens/leaderboard_screen.dart';
import 'package:cookies/screens/settings_screen.dart';
import 'package:cookies/screens/shop_screen.dart';
import 'package:cookies/screens/signin_screen.dart';
import 'package:cookies/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                    "Cookie Clicker"), //maybe say "Username's Bakery"
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                actions: [
                  Tooltip(
                    message: "Logout",
                    child: IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          // ignore: avoid_print
                          print("Signed out");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        });
                      },
                    ),
                  ),
                ],
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    hexStringToColor("ffdead"),
                    hexStringToColor("eea9b8"),
                    hexStringToColor("cb6d51"),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  isScrollable: false,
                  tabs: [
                    Tab(icon: Icon(Icons.cookie), text: 'Cookie'),
                    Tab(icon: Icon(Icons.add_business), text: 'Shop'),
                    Tab(icon: Icon(Icons.leaderboard), text: 'Leaderboard'),
                    Tab(icon: Icon(Icons.settings), text: 'Settings'),
                  ],
                )),
            body: const TabBarView(children: [
              CookiePage(),
              ShopPage(),
              LeaderboardPage(),
              SettingsPage(),
            ])),
      );
}
