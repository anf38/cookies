import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_bar.dart';
import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/color_utils.dart';

class changeEmail extends StatefulWidget {
  const changeEmail({super.key});

  @override
  State<changeEmail> createState() => _changeEmailState();
}

class _changeEmailState extends State<changeEmail> {
  TextEditingController newEmail = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Change Email",
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
                reusableTextField(
                    "Enter New Email", Icons.lock_outline, false, newEmail),
                const SizedBox(height: 20),
                reusableTextField("Confirm Password", Icons.lock_outline, true,
                    confirmPassword),
                const SizedBox(height: 20),
                signInSignUpButton("Change Email", context, () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final cred = EmailAuthProvider.credential(
                    email: user?.email ?? '',
                    password: confirmPassword.text,
                  );

                  try {
                    await user
                        ?.reauthenticateWithCredential(cred); //reauthentication
                    await user?.updateEmail(newEmail.text); //password update

                    // Password changed successfully
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppBarPage()));
                    alertBox("Success!", "Email was changed");
                  } catch (error) {
                    if (error.toString().contains("badly formatted.")) {
                      alertBox("Error!", "Put a valid email address");
                    } else if (error.toString().contains("password is invalid")) {
                      alertBox("Error!", "The password is incorrect");
                    }
                  }
                })
              ],
            ),
          ))),
    );
  }
}
