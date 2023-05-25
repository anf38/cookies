import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String yourUserName = "You";
  num yourScore = 0;
  num rankNum = 0;
  late Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .ref()
        .child('users')
        .orderByChild("score")
        .limitToFirst(10);

    ref //gets the userName from the database
        .child('users/${FirebaseAuth.instance.currentUser!.uid}/userName')
        .get()
        .then((value) {
      if (value.value != null && mounted) {
        setState(() {
          yourUserName = value.value as String;
        });
      }
    });

    ref //gets the score from the database
        .child('users/${FirebaseAuth.instance.currentUser!.uid}/score')
        .get()
        .then((value) {
      if (value.value != null && mounted) {
        setState(() {
          yourScore = value.value as num;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("STATS",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 112, 63, 63))),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 118, 118),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("Name",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                          Text(
                            yourUserName,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Cookies",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                          Text('${yourScore * -1}',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9))),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text("LEADERBOARD",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 112, 63, 63))),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 470,
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 575.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 184, 132, 132),
                ),
                child: GridView.count(
                  crossAxisCount: 1,
                  children: [
                    FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map<dynamic, dynamic> users =
                            snapshot.value as Map<dynamic, dynamic>;
                        return _buildContactItem(users: users);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactItem({required Map users}) {
    rankNum++;
    if (rankNum > 10) {
      rankNum = 1;
    }
    bool isCurrentUser = users['userName'] == yourUserName;
    //styling for the leaderboard users
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 5.0, top: 10.0),
          decoration: BoxDecoration(
            color: isCurrentUser ? const Color.fromARGB(255, 189, 118, 118) : const Color.fromARGB(50, 255, 255, 255),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rank',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    '$rankNum',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    users['userName'] as String,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Cookies',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    ((users['score'] as int) * -1).round().toString(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
