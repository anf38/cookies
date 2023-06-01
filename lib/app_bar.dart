import 'package:cookies/screens/CookiePage.dart';
import 'package:cookies/screens/leaderboard_screen.dart';
import 'package:cookies/screens/settings_screen.dart';
import 'package:cookies/screens/shop_screen.dart';
import 'package:cookies/screens/signin_screen.dart';
import 'package:cookies/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

ValueNotifier<bool> isDarkModeEnabled1 = ValueNotifier<bool>(false);

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  void initState() {
    super.initState();
    isDarkModeEnabled1.addListener(_updateTheme);
  }

  @override
  void dispose() {
    isDarkModeEnabled1.removeListener(_updateTheme);
    super.dispose();
  }

  void _updateTheme() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
                    "Cookie Clicker",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ), //maybe say "Username's Bakery"
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
                      color: Colors.white,
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
                    gradient: LinearGradient(
                      colors: isDarkModeEnabled.value
                          ? [
                              hexStringToColor("cb6d51"),
                              hexStringToColor("7b1e17"),
                              hexStringToColor("4c1d1d"),
                            ]
                          : [
                              hexStringToColor("ffdead"),
                              hexStringToColor("eea9b8"),
                              hexStringToColor("cb6d51"),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
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
