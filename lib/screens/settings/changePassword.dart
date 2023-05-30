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

  alertBox(String titleTxt, String contentTxt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(titleTxt),
          content: Text(contentTxt),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                const SizedBox(height: 30),
                reusableTextField("Enter Old Password", Icons.lock_outline, _obscureText, oldPassword),
                const SizedBox(height: 20),
                reusableTextField("Enter New Password", Icons.lock_outline, _obscureText, newPassword),
                const SizedBox(height: 20),
                reusableTextField("Confirm New Password", Icons.lock_outline, _obscureText, confirmPassword),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: _toggle,
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),




                
                signInSignUpButton("Change Password", context, () async {
                  if (newPassword.text == confirmPassword.text) {

                    final user = FirebaseAuth.instance.currentUser;
                    final cred = EmailAuthProvider.credential(
                      email: user?.email ?? '',
                      password: oldPassword.text,
                    );

                    try {
                      await user?.reauthenticateWithCredential(cred); //reauthentication
                      await user?.updatePassword(newPassword.text); //password update

                      // Password changed successfully
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppBarPage()));
                      alertBox("Success!", "Password was changed");
                    } catch (e) {
                      alertBox("Error!", "Old password is incorrect");
                    }
                  } else {
                    alertBox("Error!", "New passwords dont match");
                  }
                })
              ],
            ),
          ))),
    );
  }
}