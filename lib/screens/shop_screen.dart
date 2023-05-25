import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String yourUserName = "You";
  num yourScore = 0;
  int _tapCount = 1;
  int anotherCookieCost = 100;
  var tileColor;

  int _payment(int price) {
    //its addition because the value for yourScore is stored as a negative
    yourScore += price;
    price = (100 * _tapCount * _tapCount);

    ref
        .child('users/${FirebaseAuth.instance.currentUser!.uid}')
        .update({'score': yourScore});

    ref
        .child('users/${FirebaseAuth.instance.currentUser!.uid}')
        .update({'clickPower': _tapCount});
        anotherCookieCost = (100 * (_tapCount * _tapCount));
    return price;
  }

  @override
  void initState() {
    super.initState();

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

    ref //gets the score from the database
        .child('users/${FirebaseAuth.instance.currentUser!.uid}/clickPower')
        .get()
        .then((value) {
      if (value.value != null && mounted) {
        setState(() {
          _tapCount = value.value as int;
          anotherCookieCost = (100 * (_tapCount * _tapCount));
        });
      }
    });

    ref //if there is a change in the database, then it will change the values accordingly
        .child('users/${FirebaseAuth.instance.currentUser!.uid}')
        .onChildChanged
        .listen((event) {
      if (event.snapshot.exists && mounted && event.snapshot.key == 'score') {
        setState(() {
          yourScore = event.snapshot.value as int;
        });
      }
      if (event.snapshot.exists &&
          mounted &&
          event.snapshot.key == 'clickPower') {
        setState(() {
          _tapCount = event.snapshot.value as int;
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
            const Text(
              "STATS",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 112, 63, 63),
              ),
            ),
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
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            yourUserName,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Cookies",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${yourScore * -1}',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.cookie),
                title: const Text(
                  "Another Cookie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: AutoSizeText(
                  "Increase cookies per click by 1\nCurrent: $_tapCount",
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color.fromARGB(225, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
                isThreeLine: true,
                trailing: Text(
                  '\$$anotherCookieCost',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if ((yourScore * -1) >= anotherCookieCost) {
                      //if you can afford
                      _tapCount++;
                      anotherCookieCost = _payment(anotherCookieCost);
                    } else {
                      tileColor = const Color.fromARGB(
                          150, 189, 118, 118); // Change tileColor to invalid
                    }
                  });
                },
                tileColor: yourScore + anotherCookieCost < 1
                    ? const Color.fromARGB(255, 189, 118, 118)
                    : const Color.fromARGB(200, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text(
                  "Second Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: const Text(
                  "Subtitle 2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  // Handle the onTap action
                },
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text(
                  "Third Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: const Text(
                  "Subtitle 3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  // Handle the onTap action
                },
                enabled: false,
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.cookie),
                title: const Text(
                  "Another Cookie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: Text(
                  "Increase cookies per click by 1 Current: $_tapCount",
                  style: const TextStyle(
                    color: Color.fromARGB(225, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () => setState(() => _tapCount++),
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text(
                  "Second Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: const Text(
                  "Subtitle 2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  // Handle the onTap action
                },
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text(
                  "Third Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: const Text(
                  "Subtitle 3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  // Handle the onTap action
                },
                enabled: false,
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: const Icon(Icons.cookie),
                title: const Text(
                  "Another Cookie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                subtitle: Text(
                  "Increase cookies per click by 1 Current: $_tapCount",
                  style: const TextStyle(
                    color: Color.fromARGB(225, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
                isThreeLine: true,
                trailing: const Text(
                  "\$200",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                onTap: () => setState(() => _tapCount++),
                tileColor: const Color.fromARGB(255, 189, 118, 118),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}


//once you react quadrillion cookies, theres a shop item unlocked thats worth that much.
// its a gold star, no function whatsoever. once you reach too many gold stars, then you can get a platinum star and so on....
//when offline, it will measure the time spent away. when you come back, it will calculate how many cookies you earned while away and
//you can accept them and add it to your total. 
//have a stock market that people can invest their cookies in. it measures companies irl to automatically alter the pricing/ratings
//have a weekly lottery that people can buy tickets for
//more gambling
//gingerbread housing market
//cinnamon = illicit drug substance

//occasionally a golded cookie will show up. click it in time to earn a lot of cookies
//occasionally, Clookie will show up. click him to kick him away (Achievement name: Clookie kicker)