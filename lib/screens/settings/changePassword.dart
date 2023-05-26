import 'package:cookies/screens/CookiePage.dart';
import 'package:cookies/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_bar.dart';
import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/color_utils.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void _changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
      email: user?.email ??
          '', // Use null-aware operator and provide a default value for email
      password: currentPassword,
    );

    try {
      await user?.reauthenticateWithCredential(
          cred); // Use await to wait for the reauthentication
      await user?.updatePassword(
          newPassword); // Use await to wait for the password update

      // Password changed successfully
      // You can perform additional actions or show a success message here
    } catch (error) {
      print('Error changing password: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Change Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("ffdead"),
            hexStringToColor("eea9b8"),
            hexStringToColor("eea9b8"),
            hexStringToColor("cb6d51"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Old Password", Icons.lock_outline,
                    true, oldPassword),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter New Password", Icons.lock_outline,
                    true, newPassword),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm New Password", Icons.lock_outline,
                    true, confirmPassword),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton("Change Password", context, () {  
                  if (newPassword.text == confirmPassword.text) {
                    _changePassword(oldPassword.text, newPassword.text);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                              builder: (context) => const AppBarPage()));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text("Success!"),
                          content: const Text("Password was changed"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Message pops up saying passwords need to match
                    print("Passwords don't match");
                  }
                })
              ],
            ),
          ))),
    );
  }
}
