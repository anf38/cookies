import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  void saveUser() {
  ref
      .child('users/${FirebaseAuth.instance.currentUser!.uid}')
      .set({
        'userName': _userNameTextController.text,
        //'email': _emailTextController.text,
        //'password': _passwordTextController.text,
        'clickPower': 1,
      });
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
          "Sign Up",
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
                reusableTextField(
                  "Enter Username", 
                  Icons.person_outline, 
                  false,
                  _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email", 
                  Icons.person_outline, 
                  false,
                  _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password", 
                  Icons.lock_outline, 
                  _obscureText,
                  _passwordTextController),
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

                signInSignUpButton('SIGN UP', context, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    // ignore: avoid_print
                    print("Created New Account");
                    saveUser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppBarPage()));
                  }).catchError((error) {
                    // ignore: avoid_print
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
