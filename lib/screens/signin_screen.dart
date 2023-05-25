import 'package:cookies/screens/signup_screen.dart';
import 'package:cookies/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../reusable_widgets/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Create an animation with a Tween that will interpolate values from 1.0 to 0.9
    _animation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTapDown: (_) {
                    // When the image is pressed down, start the animation
                    _animationController.forward();
                  },
                  onTapUp: (_) {
                    // When the image is released, reverse the animation
                    _animationController.reverse();
                  },
                  onTapCancel: () {
                    // When the tap is cancelled, reverse the animation
                    _animationController.reverse();
                  },
                  child: ScaleTransition(
                    scale: _animation, // Use the animation to scale the image
                    child: logoWidget("images/cookie.png"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            //builder: (context) => CookiePage(title: 'Cookies!')));
                            builder: (context) => const AppBarPage()));
                  }).onError((error, stackTrace) {
                    // ignore: avoid_print
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
