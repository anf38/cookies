// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widget.dart';

class CookiePage extends StatefulWidget {
  const CookiePage({super.key});

  @override
  State<CookiePage> createState() => _CookiePageState();
}

class _CookiePageState extends State<CookiePage>
    with SingleTickerProviderStateMixin {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _counter = 0;
  int _clickPower = 1;

  @override
  void initState() {
    //function to run to set up the page
    super.initState();
    final DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref //if there is a change in the database, then it will change _counter accordingly
        .child('users/${FirebaseAuth.instance.currentUser!.uid}')
        .onChildChanged
        .listen((event) {
      if (event.snapshot.exists && mounted) {
        setState(() {
          _counter = event.snapshot.value as int;
        });
      }
    }); //end of _counter change

    try {
      ref //gets the score from the database and applies it to the score
          .child('users/${FirebaseAuth.instance.currentUser!.uid}/clickPower')
          .get()
          .then((value) {
        if (value.value != null && mounted) {
          setState(() {
            _clickPower = value.value as int;
          });
        }
      });
      ref //gets the score from the database and applies it to the score
          .child('users/${FirebaseAuth.instance.currentUser!.uid}/score')
          .get()
          .then((value) {
        if (value.value != null && mounted) {
          setState(() {
            _counter = value.value as int;
          });
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('no ref');
    }

    // Create an animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // Create an animation with a Tween that will interpolate values from 1.0 to 0.9
    _animation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  void _incrementCounter() {
    //function adds 1 to the score in database
    _counter -= _clickPower;
    ref //
        .child('users/${FirebaseAuth.instance.currentUser!.uid}')
        .update({'score': _counter});
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_counter * -1}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 50,
              width: 200,
            ),
            GestureDetector(
              onTapDown: (_) {
                // When the image is pressed down, start the animation
                _animationController.forward();
                _incrementCounter();
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
              height: 100,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}

//https://console.firebase.google.com/u/2/project/learning-firebase-afloate/database/learning-firebase-afloate-default-rtdb/data
