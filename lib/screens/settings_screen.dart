import 'package:cookies/screens/settings/changeEmail.dart';
import 'package:cookies/screens/settings/changePassword.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

void toggleDarkMode(bool value) {
  isDarkModeEnabled.value = value;
  isDarkModeEnabled1.value = value;
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            //ACCOUNT
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'ACCOUNT',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            //account
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Change Username",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
              onTap: () {
                setState(() {});
              },
            ),
          ),
          Padding(
            //account
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Change Email",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const changeEmail()),
                );
              },
            ),
          ),
          Padding(
            //account
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const changePassword()),
                );
              },
            ),
          ),
          Padding(
            //Notifications
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'NOTIFICATIONS',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            //Notifications
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
              onTap: () {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'APPEARANCE',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text(
                "Dark Mode",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Switch(
                value: isDarkModeEnabled.value,
                onChanged: (value) {
                  setState(() {
                    toggleDarkMode(value);
                  });
                },
                activeColor: const Color.fromARGB(255, 189, 118, 118),
              ),
              onTap: () {
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'PRIVACY AND SECURITY',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            //Privacy and Security
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                "Privacy and Security",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'HELP AND SUPPORT',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.headphones),
              title: Text(
                "Report a Bug",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const ListTile(
                title: Text(
                  'OTHER',
                  style: TextStyle(
                    color: Color.fromARGB(200, 255, 255, 255),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.question_mark_rounded),
              title: Text(
                "Delete Account",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromARGB(255, 189, 118, 118),
                size: 25,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

//change email/username/password
//reset/delete account